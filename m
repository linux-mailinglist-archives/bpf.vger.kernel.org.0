Return-Path: <bpf+bounces-27114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A685C8A93B8
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322EA1F2323C
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4603A8EF;
	Thu, 18 Apr 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="X4vXCF2j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="jH2W0cw4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEvWqQcp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179302D057
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424067; cv=none; b=l5OQw+rlSdmTeWv6sRqs9DixEUuNUm7iMGMdhK+BGIkuintCZutSAHLfVtHwXJS/isFm8CAd8xctWUbH+raFFAu28pOjhjp0xP4SPk1yvfEWLR+w/dgFxU7SQgIJhSvL94H9fbWQlTFsquxvjy8XQKJjcSO7zkmZV2JtXRJlZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424067; c=relaxed/simple;
	bh=QZQl1bQJuHMa4iZEReGajIYhuquW57914/gEV1GxX+g=;
	h=Date:To:Cc:Message-ID:References:MIME-Version:Content-Disposition:
	 In-Reply-To:Subject:Content-Type:From; b=bRiC7pVlxt99xK1+GifFEBpXXe7tseJrdFmjXSUTFY6d/cl0qRtvuCxDM5IUJO3K/dYhE36Y2abQHTnt3SDzbNiR87wXzF/TtaAYKc4AjwFvVy/hcC7zIeDTTjMCzltMbBSdkwVRd1y8ml2//9tX3DpcyCbTFDP2D24xg0yPnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=X4vXCF2j; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=jH2W0cw4 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEvWqQcp reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 85490C15170B
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713423644; bh=QZQl1bQJuHMa4iZEReGajIYhuquW57914/gEV1GxX+g=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4vXCF2jU7MxsPBzpZsTA7htNTO+bKnpkehypRpZSCdUbW7X48Liis6snhuA2++Nn
	 024T/oq3T0kuodW2lzU6Tb+HDfdvK2wDkFxk3sTtp9BV9cQU7GbYN7smm570GqQ5y2
	 B8vevFGWobvd3hhJIhJFwwcnyFL5tP9DDwPVmzpI=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5CE3CC151538;
 Thu, 18 Apr 2024 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713423644; bh=QZQl1bQJuHMa4iZEReGajIYhuquW57914/gEV1GxX+g=;
 h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=jH2W0cw4LIEWPiWjejSpUuLw7KbUPR6ugNQHYhYm8YbxrY06L4T4sSc15YmlW4sJ4
 m8wrsPzLhlVoMgTqmyG7I7ITJwj0++1paXyUWFRTWLjob/2IX0HgfAKmC8xP2dfRnz
 u4m0yP7aPIkX/xd59Cn5flUe8V//qmnvZ+RzlYFE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1B22DC14F604
 for <bpf@ietfa.amsl.com>; Fri, 12 Apr 2024 01:53:59 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=suse.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OtM_vS4d49e8 for <bpf@ietfa.amsl.com>;
 Fri, 12 Apr 2024 01:53:58 -0700 (PDT)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 56FACC14F5FB
 for <bpf@ietf.org>; Fri, 12 Apr 2024 01:53:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d8b194341eso5446261fa.3
 for <bpf@ietf.org>; Fri, 12 Apr 2024 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712912036; x=1713516836; darn=ietf.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9HCv5WXEXkcM3e4s9GxwuVLanaiJtfT2xDBOPBy8Ztg=;
 b=LEvWqQcp4BEpYPJ9oXGtZzYtsoGyLIpYAUvUMUOVHAn4/zsH4IrPDfaxI2FI3hcL0G
 HFFOFjIP2qGLJFzy/8Enho9geCUk00O3Vle5YhL39lE4NDrBCTPiJhIm64dIIYe5PyOW
 g3N08DVF9v+dbP8Fl6dIn46bmS8EhMAi8kHd0uT7Sy1VbEu0r3XDxKBdh38qB8zGT5Kb
 2Uqhx6yDbzFXyShbUipcmzazkhoreN+B3dSzE+YUi+bJJ6WC2iP3Fx6LaGwJdrFO+JPP
 iyRZQwPAvcoHHX3WU05GQSgyIy+nqrh6aOR3WNlROmjjxNY7yngudDJOFObTHgqOlLm8
 fBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712912036; x=1713516836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HCv5WXEXkcM3e4s9GxwuVLanaiJtfT2xDBOPBy8Ztg=;
 b=gZ/DjG8HCBql/1qSP0NspkNtDdtySLkOR5sxlDIqnx9XWIC5eS604dO1JfskPUdmnX
 nAIpXp2THIdz7nsXw5I047IiV74O1dnrElpG96GlEx5DNYiRVnMcptitkCdygDBWvPFu
 X0CmEIlZr3aTvp7j8fuYE5CYAF3XVlnE29AU/YjPvGPw69RCgp0p/KP04ygCBhUrcoOC
 9B+739iAOC6fPnS0k1XhQlM11YNH/F2w6eM4yIXN6JsH58KvWwnwfZdOPsQRDhkQz9xT
 +5U8AA1qPWnGB29fkvuZpzSkOOPQ1otjjQ0uNB0CUXjaTWeP5f6xuejc6+XM7KcriTQ1
 HVYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzq9phByF2BLozZ6uiIFW9E4csazLVeG0dpiUnwP7kF4MWCpO1WgfwLmaZuKX7+mcIAC7ZUQq7FRy5i+Y=
X-Gm-Message-State: AOJu0YzucMaorV0zGsF0PJo8tVweLExSVEzG6g1sERsUKurZJuAYCxyI
 Pf5vKhhp/B468Sm3we3HEHbaNKela5ukP9UfARnzUyzbieOOLJmXgLtK1xnhRh8=
X-Google-Smtp-Source: AGHT+IFSyvhmvV600yckuR3RXXhnT/HiMaiPPbLP9Bpktx86rW2y3WG1OuM9vSWWo5pDGj5dTLztzA==
X-Received: by 2002:a05:651c:205c:b0:2d9:eb66:6d39 with SMTP id
 t28-20020a05651c205c00b002d9eb666d39mr1130573ljo.19.1712912035823; 
 Fri, 12 Apr 2024 01:53:55 -0700 (PDT)
Received: from u94a ([2401:e180:8863:5c39:2e5:46b1:443c:b5c1])
 by smtp.gmail.com with ESMTPSA id
 z184-20020a6265c1000000b006ed4c430acesm2522658pfb.40.2024.04.12.01.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 01:53:55 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:53:35 +0800
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>,
 Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 bpf@ietf.org, David Vernet <void@manifault.com>
Message-ID: <m3pwq4fhoh4pecl5mahz7fhjiav4atebtbr22jfk4eqqq5hiya@g3vsc2zqlcy6>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-7-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240411122752.2873562-7-xukuohai@huaweicloud.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/opyerlU_h02n0GBt7CRK75zkk38>
X-Mailman-Approved-At: Thu, 18 Apr 2024 00:00:43 -0700
Subject: Re: [Bpf] [PATCH bpf-next v3 06/11] bpf: Fix compare error in
 function retval_range_within
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
From: Shung-Hsi Yu <shung-hsi.yu=40suse.com@dmarc.ietf.org>

On Thu, Apr 11, 2024 at 08:27:47PM +0800, Xu Kuohai wrote:
> [...]
> 24: (b4) w0 = -1                      ; R0_w=0xffffffff
> ; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
> 25: (95) exit
> At program exit the register R0 has smin=4294967295 smax=4294967295 should have been in [-4095, 0]
> 
> It can be seen that instruction "w0 = -1" zero extended -1 to 64-bit
> register r0, setting both smin and smax values of r0 to 4294967295.
> This resulted in a false reject when r0 was checked with range [-4095, 0].
> 
> Given bpf_retval_range is a 32-bit range, this patch fixes it by
> changing the compare between r0 and return range from 64-bit
> operation to 32-bit operation.
> 
> Fixes: 8fa4ecd49b81 ("bpf: enforce exact retval range on subprog/callback exit")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 05c7c5f2bec0..5393d576c76f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9879,7 +9879,7 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>  
>  static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
>  {
> -	return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
> +	return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;

Logic-wise LGTM

While the status-quo is that the return value is always truncated to
32-bit, looking back there was an attempt to use 64-bit return value for
bpf_prog_run[1] (not merged due to issue on 32-bit architectures). Also
from the reading of BPF standardization ABI it would be inferred that
return value is in 64-bit range:

  BPF has 10 general purpose registers and a read-only frame pointer register,
  all of which are 64-bits wide.
  
  The BPF calling convention is defined as:
  
  * R0: return value from function calls, and exit value for BPF programs
  ...

So add relevant people into the thread for opinions.

1: https://lore.kernel.org/bpf/20221115193911.u6prvskdzr5jevni@apollo/

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

