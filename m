Return-Path: <bpf+bounces-39379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612AA9725A8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F72836C9
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05A18DF88;
	Mon,  9 Sep 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn18dlVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA9210EC
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923823; cv=none; b=sFZFPWg9gWeaAehhj70mP6OL9puXV1EBRCOCgBPaOSoAQ60vrMsb+T5UwBLre2l2JrY0XDEC6Jx3Woz6Urxcu7hLNo2/3ebRDF1Yiocbea6PCvO2eQytaACK8sH1RjeWjdI4bwF+Mhzl5qGfGqzE4eUVqQ8lvm5GWidBzP3snK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923823; c=relaxed/simple;
	bh=vnB0AjIlyDDcMDzTvbx4YLnH+NsAh7jPQpyeUPx6RaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRFmNMyeaUm/E3x9qTrZFZEY2+cSRiAVhLzZ0hvfqNCx5FtUAVUUB4O4Nhs5NENRLEmD0fqxNw1fTi0Rt3yAf0psEewXqKf4cQ2gEH1Qh6X7EKQxp1xs649xJuaxR6SHCVllFOjtTWiV6OobtV0Gwu9TW8aCq5RdRnK7FQXqujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn18dlVM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99fd5beb6so263851585a.0
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725923820; x=1726528620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIRbXH+LHSaqQM1kmAiIJVBJS87CiiYrbmZpw6G5R+k=;
        b=kn18dlVMVdx4XNJzUsrxB9QN7mlgV/NvIjAkOWdQYuuDGs5CG5r4X9zo3E5BO2XXqp
         vJikCPHiCTBBwKLbtxViAbmdTSgbmGPoosh0TJOLlU40SpAOzADvjOB7bK1mKB4pc3dZ
         a5eNg1dp8pVgSQJIcuXtTQ8aaqV4vTTnBDSjfv4CyBhZsnYoqMb5kRTWefKHQzl2sD0m
         U0S7YJ8rPr5Sui7ejfbYxNjklCjhYCaSmdSa83qxcb7YLsJSPK8bX9MJsVx+uwNR9AkD
         bg/PJx6Og5ff9ssZfUelErgpHkPztkIjeetKuQtoFkoZXa82UBh1fqaamSZQmeXnUjX+
         yMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725923820; x=1726528620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIRbXH+LHSaqQM1kmAiIJVBJS87CiiYrbmZpw6G5R+k=;
        b=A4SS/Nxt3lZ+PZj6xMPCIoWSU/5ViwYZUkpAmr7wAbRpJEFfP5hlm06jTWTj39DFv2
         arQG0zqmmGJyi2EjIpJCrL/v3xtU2ZxGWvGVOSXaZ8rt/NpI8OwSHAxhgr9wWaqqehtS
         hKRJHcuAWHLeqxALwpMF53bGyARkk9Q9h08ZA/eaIkLtLe7d2QN26wKkjxKI8pt0tdd9
         GJ5Pjd3jQdHi9PsTp9sLPXm7hYYOXL35Dduob2ivSVA89lPKFASB0XEZpwsGSOVdBDKd
         5RaBKeQ8dzEmHMfzc6uGqsWVIXiPvwLcSs23Lh+4n2/06e4Wui9TAqCqqRMC8vEDRmkj
         U8xA==
X-Gm-Message-State: AOJu0YxJ56HKCyV3YvufH9c1LS0AXkVuEt3EkB1sjSPk/7YtTTrpOQni
	DBEbgYOe9oO3Wsmmh8ij0oDDIhP34DS8VqtWGTg28jBgf2FT6vMQoE+VsT3gndBy5BL8EMEX6jg
	KdtYXQMUln8FxQHAQQ6qLVHwTQZjMurJlAX3zkw==
X-Google-Smtp-Source: AGHT+IGvAc+p1/VoQA1YnR7DqFW0ClPHCj1RBLFiuTCVg/GQo/RKlRitQytERTIGosRF/kUg9ezonXKelCO1GRZPcNE=
X-Received: by 2002:a05:620a:199a:b0:7a9:9ecd:e685 with SMTP id
 af79cd13be357-7a9bf9ac59bmr249004385a.26.1725923819546; Mon, 09 Sep 2024
 16:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKzMAvRVpVgHLPLz5X_h_2jDfEMVNidC9sG5ykioYEhOA@mail.gmail.com>
 <20240909225952.30324-1-yunwei356@gmail.com>
In-Reply-To: <20240909225952.30324-1-yunwei356@gmail.com>
From: Yunwei 123 <yunwei356@gmail.com>
Date: Mon, 9 Sep 2024 23:16:48 +0000
Message-ID: <CAEnnukY6ye9+1uOT9ZEknNNjvwiSfPbt+S-5g93wM7Ni4BtodA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: fix some typos in comments
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei and all,

Thanks a lot for reviewing my first patch. Sorry about the
--in-reply-to mistake and name. I've fixed it and sent the v2.

Best,
Yusheng Zheng

On Mon, Sep 9, 2024 at 11:00=E2=80=AFPM Yusheng Zheng <yunwei356@gmail.com>=
 wrote:
>
> Fix some spelling errors in the code comments of libbpf:
>
> betwen -> between
> paremeters -> parameters
> knowning -> knowing
> definiton -> definition
> compatiblity -> compatibility
> overriden -> overridden
> occured -> occurred
> proccess -> process
> managment -> management
> nessary -> necessary
>
> Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
> ---
>  tools/lib/bpf/bpf_helpers.h   |  2 +-
>  tools/lib/bpf/bpf_tracing.h   |  2 +-
>  tools/lib/bpf/btf.c           |  2 +-
>  tools/lib/bpf/btf.h           |  2 +-
>  tools/lib/bpf/btf_dump.c      |  2 +-
>  tools/lib/bpf/libbpf.h        | 10 +++++-----
>  tools/lib/bpf/libbpf_legacy.h |  4 ++--
>  tools/lib/bpf/skel_internal.h |  2 +-
>  8 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 305c62817dd3..80bc0242e8dc 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -341,7 +341,7 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num =
*it) __weak __ksym;
>   * I.e., it looks almost like high-level for each loop in other language=
s,
>   * supports continue/break, and is verifiable by BPF verifier.
>   *
> - * For iterating integers, the difference betwen bpf_for_each(num, i, N,=
 M)
> + * For iterating integers, the difference between bpf_for_each(num, i, N=
, M)
>   * and bpf_for(i, N, M) is in that bpf_for() provides additional proof t=
o
>   * verifier that i is in [N, M) range, and in bpf_for_each() case i is `=
int
>   * *`, not just `int`. So for integers bpf_for() is more convenient.
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 4eab132a963e..8ea6797a2570 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -808,7 +808,7 @@ struct pt_regs;
>   * tp_btf/fentry/fexit BPF programs. It hides the underlying platform-sp=
ecific
>   * low-level way of getting kprobe input arguments from struct pt_regs, =
and
>   * provides a familiar typed and named function arguments syntax and
> - * semantics of accessing kprobe input paremeters.
> + * semantics of accessing kprobe input parameters.
>   *
>   * Original struct pt_regs* context is preserved as 'ctx' argument. This=
 might
>   * be necessary when using BPF helpers like bpf_perf_event_output().
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8d51e73d55a8..3c131039c523 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4230,7 +4230,7 @@ static bool btf_dedup_identical_structs(struct btf_=
dedup *d, __u32 id1, __u32 id
>   * consists of portions of the graph that come from multiple compilation=
 units.
>   * This is due to the fact that types within single compilation unit are=
 always
>   * deduplicated and FWDs are already resolved, if referenced struct/unio=
n
> - * definiton is available. So, if we had unresolved FWD and found corres=
ponding
> + * definition is available. So, if we had unresolved FWD and found corre=
sponding
>   * STRUCT/UNION, they will be from different compilation units. This
>   * consequently means that when we "link" FWD to corresponding STRUCT/UN=
ION,
>   * type graph will likely have at least two different BTF types that des=
cribe
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index b68d216837a9..4e349ad79ee6 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -286,7 +286,7 @@ LIBBPF_API void btf_dump__free(struct btf_dump *d);
>  LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
>
>  struct btf_dump_emit_type_decl_opts {
> -       /* size of this struct, for forward/backward compatiblity */
> +       /* size of this struct, for forward/backward compatibility */
>         size_t sz;
>         /* optional field name for type declaration, e.g.:
>          * - struct my_struct <FNAME>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 894860111ddb..0a7327541c17 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -304,7 +304,7 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
>   * definition, in which case they have to be declared inline as part of =
field
>   * type declaration; or as a top-level anonymous enum, typically used fo=
r
>   * declaring global constants. It's impossible to distinguish between tw=
o
> - * without knowning whether given enum type was referenced from other ty=
pe:
> + * without knowing whether given enum type was referenced from other typ=
e:
>   * top-level anonymous enum won't be referenced by anything, while embed=
ded
>   * one will.
>   */
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 64a6a3d323e3..6917653ef9fa 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -152,7 +152,7 @@ struct bpf_object_open_opts {
>          * log_buf and log_level settings.
>          *
>          * If specified, this log buffer will be passed for:
> -        *   - each BPF progral load (BPF_PROG_LOAD) attempt, unless over=
riden
> +        *   - each BPF progral load (BPF_PROG_LOAD) attempt, unless over=
ridden
>          *     with bpf_program__set_log() on per-program level, to get
>          *     BPF verifier log output.
>          *   - during BPF object's BTF load into kernel (BPF_BTF_LOAD) to=
 get
> @@ -455,7 +455,7 @@ LIBBPF_API int bpf_link__destroy(struct bpf_link *lin=
k);
>  /**
>   * @brief **bpf_program__attach()** is a generic function for attaching
>   * a BPF program based on auto-detection of program type, attach type,
> - * and extra paremeters, where applicable.
> + * and extra parameters, where applicable.
>   *
>   * @param prog BPF program to attach
>   * @return Reference to the newly created BPF link; or NULL is returned =
on error,
> @@ -679,7 +679,7 @@ struct bpf_uprobe_opts {
>  /**
>   * @brief **bpf_program__attach_uprobe()** attaches a BPF program
>   * to the userspace function which is found by binary path and
> - * offset. You can optionally specify a particular proccess to attach
> + * offset. You can optionally specify a particular process to attach
>   * to. You can also optionally attach the program to the function
>   * exit instead of entry.
>   *
> @@ -1593,11 +1593,11 @@ LIBBPF_API int perf_buffer__buffer_fd(const struc=
t perf_buffer *pb, size_t buf_i
>   * memory region of the ring buffer.
>   * This ring buffer can be used to implement a custom events consumer.
>   * The ring buffer starts with the *struct perf_event_mmap_page*, which
> - * holds the ring buffer managment fields, when accessing the header
> + * holds the ring buffer management fields, when accessing the header
>   * structure it's important to be SMP aware.
>   * You can refer to *perf_event_read_simple* for a simple example.
>   * @param pb the perf buffer structure
> - * @param buf_idx the buffer index to retreive
> + * @param buf_idx the buffer index to retrieve
>   * @param buf (out) gets the base pointer of the mmap()'ed memory
>   * @param buf_size (out) gets the size of the mmap()'ed region
>   * @return 0 on success, negative error code for failure
> diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.=
h
> index 1e1be467bede..60b2600be88a 100644
> --- a/tools/lib/bpf/libbpf_legacy.h
> +++ b/tools/lib/bpf/libbpf_legacy.h
> @@ -76,7 +76,7 @@ enum libbpf_strict_mode {
>          * first BPF program or map creation operation. This is done only=
 if
>          * kernel is too old to support memcg-based memory accounting for=
 BPF
>          * subsystem. By default, RLIMIT_MEMLOCK limit is set to RLIM_INF=
INITY,
> -        * but it can be overriden with libbpf_set_memlock_rlim() API.
> +        * but it can be overridden with libbpf_set_memlock_rlim() API.
>          * Note that libbpf_set_memlock_rlim() needs to be called before
>          * the very first bpf_prog_load(), bpf_map_create() or bpf_object=
__load()
>          * operation.
> @@ -97,7 +97,7 @@ LIBBPF_API int libbpf_set_strict_mode(enum libbpf_stric=
t_mode mode);
>   * @brief **libbpf_get_error()** extracts the error code from the passed
>   * pointer
>   * @param ptr pointer returned from libbpf API function
> - * @return error code; or 0 if no error occured
> + * @return error code; or 0 if no error occurred
>   *
>   * Note, as of libbpf 1.0 this function is not necessary and not recomme=
nded
>   * to be used. Libbpf doesn't return error code embedded into the pointe=
r
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.=
h
> index 1e82ab06c3eb..0875452521e9 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -107,7 +107,7 @@ static inline void skel_free(const void *p)
>   * The loader program will perform probe_read_kernel() from maps.rodata.=
initial_value.
>   * skel_finalize_map_data() sets skel->rodata to point to actual value i=
n a bpf map and
>   * does maps.rodata.initial_value =3D ~0ULL to signal skel_free_map_data=
() that kvfree
> - * is not nessary.
> + * is not necessary.
>   *
>   * For user space:
>   * skel_prep_map_data() mmaps anon memory into skel->rodata that can be =
accessed directly.
> --
> 2.43.0
>

