Return-Path: <bpf+bounces-45795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468F9DB187
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA39AB20EC5
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5355896;
	Thu, 28 Nov 2024 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPBgGebI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EE45005
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732761597; cv=none; b=AdPgBpgGsRGvQ0Ip2R15ZIyqYOMTjLi+wXMzRv//kk4SMkhpFpAHIDXSUWr9Bpmhnu3C0SMwnF9AJwfW2RSRALw5F4NaeRZffPBTThd20f5zHuWVOF7bx+yf/iaNEHSU6rc6FJCnGF2qOZqFCChcJQ+gD9ZgCRUffNZkY6JknEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732761597; c=relaxed/simple;
	bh=DFCudm523iusx1QHTER2EWnEB0X06KH3REsTlYTb5cY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Atu/TkAgQ7ekQcFXGHNkspDuq4DX6z19F1NSY+6KqGSYLiNUAz7rF7tlbVfcTuHjYxu3jMGw5jWsjlqPNE7sPp6yP8nXm69/luqPviydw+6dj6piNb+kkWl6SkvrS/vjnLlPjy04AlRvdoYzLkGo39IMSWHhb/AVCnA4lUuAO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPBgGebI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso209305a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732761596; x=1733366396; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mCFZa9WUQ9QubxDOrtPS1I0Rlra1N0kmhT5+GEbobDU=;
        b=NPBgGebIogaFeXssq/XyZrtgDk/b96r7erNjTRkpeGGI46umaxDlg5RrH7kOZi9FYv
         GanyeSPQ2ioFVoexJjOqfSMXFSCZawsKJw+s07MDTsmnIu9rhbHJmHDRapptvSmWz9w8
         q/XFuPIX+oFVD8Hk5Ged27vH1GcFCPs3aq2tQQO71GvE5VBzHY95tyzOkebPfa8rRSpu
         C7JoazD/kVjJslkVU1WaYLWuwuQu+kCrOp9MI8VcbA8C7IXNQdTWRzUjTGjsCtpbMiZ0
         Z6SbqU/rrZulqVN6TtuVF8Guvf4Xw5qi/TvkzeyrlZJ3LC4Kp10YuNFHnF8LsQOSDA10
         CuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732761596; x=1733366396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCFZa9WUQ9QubxDOrtPS1I0Rlra1N0kmhT5+GEbobDU=;
        b=P0xYzhB8/AcpIEvZg22pDLl7P6Vmgf/gz1T1TszpCZFBa32Hc/4wq9jc/qq0gO4JYZ
         rmoDUVBSyS8Ts4GSf6H6gfjdJHHOEDdP7jxrUY6t73iBJZG0Jhy4/L++K+32qgStDHG0
         6m1QUmFSU32kVJal/Ale3j2/eusGwWZz5MvxuC5/LzS9wx4ShC46NzlPZTLWJ6TdGt6p
         LpbCdt7vyDOOmh7ANMi7JNpkm5Ucxmw7cznF99dkpLn1d+B3+XULNSo43rLnjqJ94z4I
         qQMlFTbZNkXzWKI/dhMS+3v6ewV7GxIJHFnqhsIxM0ZBWJg4WGlx16rmyPwYIBTZyI6G
         K5zA==
X-Forwarded-Encrypted: i=1; AJvYcCVFNXptWBuZZyzEAkZng6FeDI4LhjbqYUA0r4gHkWFPbbcP/egummgb0wImWgt2qye7riM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsG3ZJ+ARd/JHxwLFyvj7gsWrqEpIpXJEpQXZngYldOg7QoOr
	/r2HT80Dkg390l8gTxQ7+3PjjXrTVqx4qtwjaGhCqiKX7sd4w5Yt
X-Gm-Gg: ASbGnct6J0xOuxGVER+1LtOryNUWPMULUhYa+dUvlpC3qxTwc+Os4IdsCmsU56eGk+L
	IXo1IFEvqFu7se8Nv+Q6GEzIpWY72CzHlWQOZA2epMSPaQgj7IDCyNaGOx93cZ2nMNtgOe2G1F3
	bIWc2RLFoVVCsbVxc2EgGCmPw7UNZWdZ4ovpPv7+6TUI3+JKVT/hTJDb4mXvDu0LBuKKPB4rpwv
	Txq1+6lR1MrG3l8X+KgryAo9FD+HnBTpY51q5tY6qrYW7U=
X-Google-Smtp-Source: AGHT+IEbxwb5ZJRW8DdA4AgNvZmbZ07rbu9axnzIC06jCTuSZllIvY8yFQDDCvy6BQ41k16mfodadQ==
X-Received: by 2002:a05:6a20:a120:b0:1e0:cfc0:df39 with SMTP id adf61e73a8af0-1e0e0afa682mr6992440637.3.1732761595738;
        Wed, 27 Nov 2024 18:39:55 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417614basm316350b3a.11.2024.11.27.18.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 18:39:55 -0800 (PST)
Message-ID: <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Consolidate locks and reference
 state in verifier state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, kernel-team@fb.com
Date: Wed, 27 Nov 2024 18:39:50 -0800
In-Reply-To: <20241127165846.2001009-2-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
> Currently, state for RCU read locks and preemption is in
> bpf_verifier_state, while locks and pointer reference state remains in
> bpf_func_state. There is no particular reason to keep the latter in
> bpf_func_state. Additionally, it is copied into a new frame's state and
> copied back to the caller frame's state everytime the verifier processes
> a pseudo call instruction. This is a bit wasteful, given this state is
> global for a given verification state / path.
>=20
> Move all resource and reference related state in bpf_verifier_state
> structure in this patch, in preparation for introducing new reference
> state types in the future.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

lgtm, but please fix the 'print_verifier_state' note below.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  include/linux/bpf_verifier.h |  11 ++--
>  kernel/bpf/log.c             |  11 ++--
>  kernel/bpf/verifier.c        | 112 ++++++++++++++++-------------------
>  3 files changed, 64 insertions(+), 70 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f4290c179bee..af64b5415df8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -315,9 +315,6 @@ struct bpf_func_state {
>  	u32 callback_depth;
> =20
>  	/* The following fields should be last. See copy_func_state() */
> -	int acquired_refs;
> -	int active_locks;
> -	struct bpf_reference_state *refs;
>  	/* The state of the stack. Each element of the array describes BPF_REG_=
SIZE
>  	 * (i.e. 8) bytes worth of stack memory.
>  	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
> @@ -419,9 +416,13 @@ struct bpf_verifier_state {
>  	u32 insn_idx;
>  	u32 curframe;
> =20
> -	bool speculative;
> +	struct bpf_reference_state *refs;
> +	u32 acquired_refs;
> +	u32 active_locks;
> +	u32 active_preempt_locks;
>  	bool active_rcu_lock;
> -	u32 active_preempt_lock;
> +
> +	bool speculative;

Nit: pahole says there are two holes here:

     $ pahole kernel/bpf/verifier.o
     ...
     struct bpf_verifier_state {
        struct bpf_func_state *    frame[8];             /*     0    64 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct bpf_verifier_state * parent;              /*    64     8 */
        u32                        branches;             /*    72     4 */
        u32                        insn_idx;             /*    76     4 */
        u32                        curframe;             /*    80     4 */

        /* XXX 4 bytes hole, try to pack */

        struct bpf_reference_state * refs;               /*    88     8 */
        u32                        acquired_refs;        /*    96     4 */
        u32                        active_locks;         /*   100     4 */
        u32                        active_preempt_locks; /*   104     4 */
        u32                        active_irq_id;        /*   108     4 */
        bool                       active_rcu_lock;      /*   112     1 */
        bool                       speculative;          /*   113     1 */
        bool                       used_as_loop_entry;   /*   114     1 */
        bool                       in_sleepable;         /*   115     1 */
        u32                        first_insn_idx;       /*   116     4 */
        u32                        last_insn_idx;        /*   120     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
        struct bpf_verifier_state * loop_entry;          /*   128     8 */
        u32                        insn_hist_start;      /*   136     4 */
        u32                        insn_hist_end;        /*   140     4 */
        u32                        dfs_depth;            /*   144     4 */
        u32                        callback_unroll_depth; /*   148     4 */
        u32                        may_goto_depth;       /*   152     4 */

        /* size: 160, cachelines: 3, members: 22 */
        /* sum members: 148, holes: 2, sum holes: 8 */

    maybe move the 'refs' pointer?
    e.g. moving it after 'parent' makes both holes disappear.

>  	/* If this state was ever pointed-to by other state's loop_entry field
>  	 * this flag would be set to true. Used to avoid freeing such states
>  	 * while they are still in use.
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 4a858fdb6476..8b52e5b7504c 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifier_env *=
env,
>  void print_verifier_state(struct bpf_verifier_env *env, const struct bpf=
_func_state *state,
>  			  bool print_all)
>  {
> +	struct bpf_verifier_state *vstate =3D env->cur_state;

This is not always true.
For example, __mark_chain_precision does 'print_verifier_state(env, func, t=
rue)'
for func obtained as 'func =3D st->frame[fr];' where 'st' iterates over par=
ents
of env->cur_state.

>  	const struct bpf_reg_state *reg;
>  	int i;
> =20

[...]


