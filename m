Return-Path: <bpf+bounces-7980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566377F930
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC81C28200E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA21428A;
	Thu, 17 Aug 2023 14:35:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399313FFC
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 14:35:34 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159C2D74;
	Thu, 17 Aug 2023 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2mhf3+7pnlBduP+grrR6sjH7pJmDpqz8p+j4N+RtgnU=; b=eKtybZ8Kk9Ur57xSPvXeV4ZLiY
	Ku6z5+YOYpSpZ/rjIjACudosdrWZmGF9/kRNGFlWMb5NwR+u8Kj7G39q1DB5pjR7QNm+9DTjo+akP
	I1fOtAsvMN2r5MO9ul13wu52eo7nFG1c/fyMe9aE48y/wLARx6jbM/bNg89/J6z0dr+kKYGqsEm1/
	qR+SLuuvdC+oB/BVUNsR8EUGSb4Es3+6QgRtvuwA9fdnBSi/chF7vTiUBBOezh8roNf9rYLkHq8R2
	f5MGLz/HJKYtVCtZ92UN1ix1DH4WvxwEXQYvWbO8cYhko2iI/mIs20prVUwBxnkmirmiXU/ciAtkr
	pv4R5SuQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWe5w-000KAi-FX; Thu, 17 Aug 2023 16:35:28 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWe5v-000Rs4-CP; Thu, 17 Aug 2023 16:35:27 +0200
Subject: Re: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for
 globally-linked kfuncs
To: David Vernet <void@manifault.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>, kernel test robot <lkp@intel.com>
References: <20230816150634.1162838-1-void@manifault.com>
 <2d530dec-e6c2-5e3a-ccf2-d65039a9969d@linux.dev>
 <CAADnVQKtWkPWMG+F-Tkf3YXeMnC=Xwi8GA5xJMaqi725tgHSTw@mail.gmail.com>
 <20230817040107.GC1295964@maniforge>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d49a61ba-10c0-2094-10c9-60a723776f04@iogearbox.net>
Date: Thu, 17 Aug 2023 16:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230817040107.GC1295964@maniforge>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 6:01 AM, David Vernet wrote:
> On Wed, Aug 16, 2023 at 08:48:16PM -0700, Alexei Starovoitov wrote:
>> On Wed, Aug 16, 2023 at 8:38 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> On 8/16/23 8:06 AM, David Vernet wrote:
>>>> We recently got an lkp warning about missing declarations, as in e.g.
>>>> [0]. This warning is largely redundant with -Wmissing-prototypes, which
>>>> we already disable for kfuncs that have global linkage and are meant to
>>>> be exported in BTF, and called from BPF programs. Let's also disable
>>>> -Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
>>>> reproduce the warning even on W <= 3, so I can't actually be 100% sure
>>>> this fixes the issue.
>>>>
>>>> [0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/
>>>
>>> Okay, I just got a similar email to [0] which complains
>>>     bpf_obj_new_impl, ..., bpf_cast_to_kern_ctx
>>> missing declarations.
>>>
>>> In the email, the used compiler is
>>> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
>>>
>>> Unfortunately, I did not have gcc-7 to verify this.
>>> Also, what is the minimum gcc version kernel supports? 5.1?
>>
>> pahole and BTF might be broken in such old GCC too.
>> Maybe we should add:
>> config BPF_SYSCALL
>>          depends on GCC_VERSION >= 90000 || CLANG_VERSION >= 130000
> 
> It seems prudent to formally declare minimum compiler versions. Though
> modern gcc and clang also support -Wmissing-declarations, so maybe we
> should merge this patch regardless? Just unfortunate to have to add even
> more boilerplate just to get the compiler off our backs.

Urgh, to restrict BPF syscall with such `depends on` would be super ugly. Why
can't we just move this boilerplate behind a macro instead of copying this
everywhere? For example the below on top of your patch builds just fine on my
side:

diff --git a/include/linux/btf.h b/include/linux/btf.h
index df64cc642074..6a873a652001 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -83,6 +83,16 @@
   */
  #define __bpf_kfunc __used noinline

+#define __bpf_kfunc_start	\
+	__diag_push();	\
+	__diag_ignore_all("-Wmissing-prototypes",	\
+			  "Global functions as their definitions will be in vmlinux BTF");	\
+	__diag_ignore_all("-Wmissing-declarations",	\
+			  "Global functions as their definitions will be in vmlinux BTF");
+
+#define __bpf_kfunc_end	\
+	__diag_pop();
+
  /*
   * Return the name of the passed struct, if exists, or halt the build if for
   * example the structure gets renamed. In this way, developers have to revisit
diff --git a/net/core/filter.c b/net/core/filter.c
index c2b32b94c6bd..08dd0dd710dd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11724,11 +11724,7 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
  	return func;
  }

-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in vmlinux BTF");
-__diag_ignore_all("-Wmissing-declarations",
-		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc_start
  __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
  				    struct bpf_dynptr_kern *ptr__uninit)
  {
@@ -11754,7 +11750,7 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,

  	return 0;
  }
-__diag_pop();
+__bpf_kfunc_end

  int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
  			       struct bpf_dynptr_kern *ptr__uninit)

Thanks,
Daniel

