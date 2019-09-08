Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4603EACA73
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2019 05:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIHDhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Sep 2019 23:37:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42071 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfIHDhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 Sep 2019 23:37:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so9482080lje.9
        for <bpf@vger.kernel.org>; Sat, 07 Sep 2019 20:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rdna-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y8AnyqcbwPfyfiiDy3zIIs0GsMNBXL9rg1QBTReDG94=;
        b=rP4nI6iZUe+13wudncHldtTL1a7kafaCxkz1Uu7kR5pzL4TZD7Uz1TzuBboEAdmU6f
         wmLTOhjtRGXbJdHTP8n1YWnmrP0WeDsoa8r2XboK++bde9BAOqYVBv4qNr1mGJ+HmfYq
         UwJthICaTHY6Zt5Y9eKX4JzQEb8GpKhZQkxlMvZZVeTfY8Q4ToNpPZbB/Vg1EubFVfvV
         7RBCHB+MNhQFy8stWP23hWIvduJ8uMoq68eeuS7r13VKuaNGCFOrgO21LeRGsA18sRtp
         rndw4p88cCOKfhs23n/UpdAsjQhtmlsDftC1175ssoORVSx9waJpuIEEzyfgyznn8l3U
         6d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y8AnyqcbwPfyfiiDy3zIIs0GsMNBXL9rg1QBTReDG94=;
        b=h/rneJ/EAkTAfHkuQSO0Hh3IBfHUPOLQo7D2xIzBIQOwrGsL20lmzWDcGnm3Ab0wch
         GUotktVFVSGWVMwemUeR5eG+24zYH3WLmvz/X6t4tTSw31mSEgF7XgWzlrJ3zy+jbkLo
         RrTriumiboFxHwt79gP2DxSOo7qiRy+3I63jFtPJJTcCUbISyz4tI3DFC5RfUM5LLptU
         m/q1AeA08kwnuGvoYUkxzlepZixayOqB9Ef34YH53wRWnmbq0nhxrforKao8Ls+UQoBG
         0YUOxeX5i4nYS4q8NenYy/8GdGzeU3K/28GrBLhybpIheSkriYsdh1Re9O0dnAqBBe8q
         EO5A==
X-Gm-Message-State: APjAAAX7l31Co1dF1ANKEVFipe7w4bkj2KtapqvAMNaNAmDl0Kfa0MaO
        pOIubBDs2qRwlB0/W2B1v4uSNg==
X-Google-Smtp-Source: APXvYqwZ9Oh/rnvxzqaaqETjxMThRVRPygw2PMiccJUY4baehXmNsZd8OjPJCXYN3DM5hwf/QKQcXw==
X-Received: by 2002:a2e:5358:: with SMTP id t24mr11258883ljd.209.1567913859019;
        Sat, 07 Sep 2019 20:37:39 -0700 (PDT)
Received: from localhost ([62.117.96.61])
        by smtp.gmail.com with ESMTPSA id p12sm1750553ljn.15.2019.09.07.20.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 20:37:38 -0700 (PDT)
Date:   Sun, 8 Sep 2019 06:37:36 +0300
From:   Andrey Ignatov <rdna@rdna.ru>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Andrey Ignatov <rdna@fb.com>, Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
Message-ID: <20190908033652.GA41624@rdna-mbp>
References: <20190816105300.49035-1-iii@linux.ibm.com>
 <55d0fca4-099a-9fb8-8dcd-9cca31e18063@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55d0fca4-099a-9fb8-8dcd-9cca31e18063@iogearbox.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> [Wed, 4 Sep 2019 00:13:03 +0200]:
> On 8/16/19 12:53 PM, Ilya Leoshkevich wrote:
> > "ctx:file_pos sysctl:read write ok" fails on s390 with "Read value  !=
> > nux". This is because verifier rewrites a complete 32-bit
> > bpf_sysctl.file_pos update to a partial update of the first 32 bits of
> > 64-bit *bpf_sysctl_kern.ppos, which is not correct on big-endian
> > systems.
> > 
> > Fix by using an offset on big-endian systems.
> > 
> > Ditto for bpf_sysctl.file_pos reads. Currently the test does not detect
> > a problem there, since it expects to see 0, which it gets with high
> > probability in error cases, so change it to seek to offset 3 and expect
> > 3 in bpf_sysctl.file_pos.
> > 
> > Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > v1->v2: Merge bpf_ctx_narrow_load_shift and
> > bpf_ctx_narrow_access_offset.
> > 
> >   include/linux/filter.h                    |  8 ++++----
> >   kernel/bpf/cgroup.c                       | 10 ++++++++--
> >   kernel/bpf/verifier.c                     |  4 ++--
> >   tools/testing/selftests/bpf/test_sysctl.c |  9 ++++++++-
> >   4 files changed, 22 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 92c6e31fb008..2ce57645f3cd 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -749,14 +749,14 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
> >   }
> >   static inline u8
> > -bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
> > +bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
> >   {
> > -	u8 load_off = off & (size_default - 1);
> > +	u8 access_off = off & (size_default - 1);
> >   #ifdef __LITTLE_ENDIAN
> > -	return load_off * 8;
> > +	return access_off;
> >   #else
> > -	return (size_default - (load_off + size)) * 8;
> > +	return size_default - (access_off + size);
> >   #endif
> >   }
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 0a00eaca6fae..00c4647ce92a 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1325,6 +1325,7 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
> >   				     struct bpf_prog *prog, u32 *target_size)
> >   {
> >   	struct bpf_insn *insn = insn_buf;
> > +	u32 read_size;
> >   	switch (si->off) {
> >   	case offsetof(struct bpf_sysctl, write):
> > @@ -1356,7 +1357,9 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
> >   				treg, si->dst_reg,
> >   				offsetof(struct bpf_sysctl_kern, ppos));
> >   			*insn++ = BPF_STX_MEM(
> > -				BPF_SIZEOF(u32), treg, si->src_reg, 0);
> > +				BPF_SIZEOF(u32), treg, si->src_reg,
> > +				bpf_ctx_narrow_access_offset(
> > +					0, sizeof(u32), sizeof(loff_t)));
> >   			*insn++ = BPF_LDX_MEM(
> >   				BPF_DW, treg, si->dst_reg,
> >   				offsetof(struct bpf_sysctl_kern, tmp_reg));
> > @@ -1365,8 +1368,11 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
> >   				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
> >   				si->dst_reg, si->src_reg,
> >   				offsetof(struct bpf_sysctl_kern, ppos));
> > +			read_size = bpf_size_to_bytes(BPF_SIZE(si->code));
> >   			*insn++ = BPF_LDX_MEM(
> > -				BPF_SIZE(si->code), si->dst_reg, si->dst_reg, 0);
> > +				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
> > +				bpf_ctx_narrow_access_offset(
> > +					0, read_size, sizeof(loff_t)));
> 
> I see what you're doing, but generally I'm a bit puzzled on why we need these
> partial store/loads and cannot access the full loff_t value internally with the
> rewrite. Why was BPF_SIZEOF(u32) chosen in the first place? Looks like git history
> doesn't have any useful insight here ... Andrey mind to put some clarifications
> on this? Thx

Hi Daniel,

Sorry for delay, I took a week of vacation w/ pretty limited Internet
access and w/o access to my work e-mail (so answering from personal
one).

loff_t is signed and can be negative, but file position used in
bpf_sysctl ctx can only be >= 0 since negative file position doesn't
make sense here. When picking up the unsigned int size I made an
assumption that writing >4GB to sysctl file in /proc/sys would never be
needed in practice so I chose u32. This also allowed not to care about
negative values passed to loff_t since MSB is never touched and stays
zero.

You're right the commit message could be more detailed on this part.

One thing I missed in the initial patch though is the endianness and,
yes, making the code play well with both LE and BE requires this
additional work.


> >   		}
> >   		*target_size = sizeof(u32);
> >   		break;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c84d83f86141..d1d4c995a9eb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8616,8 +8616,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >   		}
> >   		if (is_narrower_load && size < target_size) {
> > -			u8 shift = bpf_ctx_narrow_load_shift(off, size,
> > -							     size_default);
> > +			u8 shift = bpf_ctx_narrow_access_offset(
> > +				off, size, size_default) * 8;
> >   			if (ctx_field_size <= 4) {
> >   				if (shift)
> >   					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
> > diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
> > index a3bebd7c68dd..abc26248a7f1 100644
> > --- a/tools/testing/selftests/bpf/test_sysctl.c
> > +++ b/tools/testing/selftests/bpf/test_sysctl.c
> > @@ -31,6 +31,7 @@ struct sysctl_test {
> >   	enum bpf_attach_type attach_type;
> >   	const char *sysctl;
> >   	int open_flags;
> > +	int seek;
> >   	const char *newval;
> >   	const char *oldval;
> >   	enum {
> > @@ -139,7 +140,7 @@ static struct sysctl_test tests[] = {
> >   			/* If (file_pos == X) */
> >   			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
> >   				    offsetof(struct bpf_sysctl, file_pos)),
> > -			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
> > +			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 3, 2),
> >   			/* return ALLOW; */
> >   			BPF_MOV64_IMM(BPF_REG_0, 1),
> > @@ -152,6 +153,7 @@ static struct sysctl_test tests[] = {
> >   		.attach_type = BPF_CGROUP_SYSCTL,
> >   		.sysctl = "kernel/ostype",
> >   		.open_flags = O_RDONLY,
> > +		.seek = 3,
> >   		.result = SUCCESS,
> >   	},
> >   	{
> > @@ -1442,6 +1444,11 @@ static int access_sysctl(const char *sysctl_path,
> >   	if (fd < 0)
> >   		return fd;
> > +	if (test->seek && lseek(fd, test->seek, SEEK_SET) == -1) {
> > +		log_err("lseek(%d) failed", test->seek);
> > +		goto err;
> > +	}
> > +
> >   	if (test->open_flags == O_RDONLY) {
> >   		char buf[128];
> > 
> 

-- 
Andrey Ignatov
