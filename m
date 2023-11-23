Return-Path: <bpf+bounces-15747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485F7F5EF2
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 13:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BB5281CC2
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3624A0D;
	Thu, 23 Nov 2023 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7NAxxBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7791;
	Thu, 23 Nov 2023 04:22:11 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-778940531dbso43289785a.0;
        Thu, 23 Nov 2023 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700742130; x=1701346930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9b7hxZxggUNzWPZcEt2SSt9tvfb5uiUa5fxRekt8xM=;
        b=m7NAxxBZQdgQaDGWQHbgh+vTzt8lhp2V6ju3wXOJ5gadCmS1MA7iRQfjre5Py+8+qP
         kZZ0lODUNrcLd03D+JveLu5AOpheqd3pN88MNybXQk9ll8SuLUSD+VpJBq3erjCy3svQ
         v2Rzg2rG1L9qNGqBWfLP69YqbAApm4GpZ758wrm5NzsTTznHc6Jhh9P96u1vSHP/xtL8
         3IVGeMwFQlMXXTsUfDIH+R4ByfYTagpeiUqfee1pTZFKfbeC9/IScYTB0oCUNzcu7SyP
         vMKhuQCZT5JT9Q1s1v8+scvNQSiSqAokohpJezGX9t9eDVPYLjcIdGrn5QcqdwZquYWW
         BJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700742130; x=1701346930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9b7hxZxggUNzWPZcEt2SSt9tvfb5uiUa5fxRekt8xM=;
        b=Zh8bPkIuHLB1jWZqOfMltU+FCBV8rXH+kTuD5yEMAoJ667shppJAnXqrXG6DfgFpw8
         RI3v8qKjLRPd2s++awAQPxgxQ56024Lz2ULlKy5depIqNwva5hl1XcAj3P94PFo/n4NA
         ikGhu71ZnUs8vhx3sUIPQBI03HSYn83VU1prsygzys729h15ulzqreesY4HVGMY+TDg4
         F+41+qRfiqG9EQoV71Haq5eUGQC5A2P+wkTAYR/H2WyT2a+Runij4SAhp3AzYecRS4sP
         jVFbCyQWDv/8BZzW31y7nOU5IrBjXCVuS3u4jMev6gnDq65YJ7ZycigH46u0V17X+b4N
         d36A==
X-Gm-Message-State: AOJu0Yyz5sp/WZbcip225al3Bde3HijPxP7sb2j2kyLwKEqeY2dpV6EN
	tMw/EEYXQ0cCiiDz0xEmzFfPqIpxizPBshMMuw4=
X-Google-Smtp-Source: AGHT+IGV5ARiTvmQFIAC9uDVavWcbdxbAY4C8q2cxi8gW6E6IUDziRn+hFG4aSjasmgZgK5w/Ye/bBVfOR6njOUoJ4g=
X-Received: by 2002:ad4:58e5:0:b0:67a:e8c:863b with SMTP id
 di5-20020ad458e5000000b0067a0e8c863bmr96257qvb.63.1700742130607; Thu, 23 Nov
 2023 04:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122141559.4228-1-laoar.shao@gmail.com> <20231122141559.4228-3-laoar.shao@gmail.com>
 <87il5t7zi3.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87il5t7zi3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 23 Nov 2023 20:21:33 +0800
Message-ID: <CALOAHbDwyFg+SPGACsOoWU9fo48paX4O_vc2OYaDJ2uaq=pQdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] mm: mempolicy: Revise comment regarding
 mempolicy mode flags
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, omosnace@redhat.com, mhocko@suse.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 2:32=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yafang Shao <laoar.shao@gmail.com> writes:
>
> > MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES, and MPOL_F_NUMA_BALANCING a=
re
> > mode flags applicable to both set_mempolicy(2) and mbind(2) system call=
s.
> > It's worth noting that MPOL_F_NUMA_BALANCING was initially introduced i=
n
> > commit bda420b98505 ("numa balancing: migrate on fault among multiple b=
ound
> > nodes") exclusively for set_mempolicy(2). However, it was later made a
> > shared flag for both set_mempolicy(2) and mbind(2) following
> > commit 6d2aec9e123b ("mm/mempolicy: do not allow illegal
> > MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()").
> >
> > This revised version aims to clarify the details regarding the mode fla=
gs.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
>
> Thanks for fixing this.
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> And, please revise the manpage for mbind() too.  As we have done for
> set_mempolicy(),
>
> https://lore.kernel.org/all/20210120061235.148637-3-ying.huang@intel.com/

Thanks for your review. will do it.

--=20
Regards
Yafang

