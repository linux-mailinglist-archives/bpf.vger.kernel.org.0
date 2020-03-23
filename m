Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972B818F34F
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 12:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgCWLCb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 07:02:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34102 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgCWLCa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 07:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584961349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFWZtCE0geh8vzmxiEFtkBHNKyKQR3wg3fSUobGXe5Y=;
        b=hGWDGAExSgDxMhJ6TVVkCztoeHIv1esdGqquRSCm2fm1vMFqV+o2tEIy/6WK8I4EaLDHTU
        dYIEN/2Fcesb9NLGpN31jVX2pGXXkieIEQ2hxOEaJEY0yNYnuZ5gEIw0NDtPmmE8FLyASA
        wN4R0TVJtoUU+Xia5JhFXv1zEEmKwR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-KzPe3XmnP-KD6p3_z2_Fqw-1; Mon, 23 Mar 2020 07:02:27 -0400
X-MC-Unique: KzPe3XmnP-KD6p3_z2_Fqw-1
Received: by mail-wm1-f69.google.com with SMTP id w9so805900wmi.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 04:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JFWZtCE0geh8vzmxiEFtkBHNKyKQR3wg3fSUobGXe5Y=;
        b=DO4ZMka24Z5EBipLPUaaa66N9Kfg9QSvlGOGsFCN1WxgdMkiDGA+ZmkJnHwhPeEkom
         WtbjSJgHF/EUfYzP/6SGo8gVLwqLujy9KcD++CnDS2OfyeCy+w4zh/mxnPSjWhR4CuvG
         sE9MCgC/sZVTsrIOLwDbSu8DBA4PNBKGZPBAtvcav18psO50b8y45pj4x4wLWE3hDoz4
         cTmJk1FVdOA01Fp1lUKHANRRUN93ULFzZw4Qeiund9H4VJEZgsAEg3AlX+/6n4foDjFZ
         9hIa8YnOgNRYIUQlYHIMNx+T+gSwECz5/vmeXfaKsjp8dRVV7TnCXnbbs5e3VW1umKop
         A2fQ==
X-Gm-Message-State: ANhLgQ10AJfCx8HIqFP1MnxD52DQw6i/fU9AbbIbn9ySz3e33i482lQK
        S+GZ7G+7MjMk+/Y57g3Mr1wfJ6Svo8qO2HRVbarJQxco8y2FAyg+4ItenE3hHCVqu6RWxJCrTfn
        9wy+hr7c5bj2s
X-Received: by 2002:adf:f812:: with SMTP id s18mr15379605wrp.380.1584961346114;
        Mon, 23 Mar 2020 04:02:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGv10RSyGqDuwfYfq+OFgJc0cOvbFVxy7ZkdYU5xePikU2fVsNx/7REQJ1RZBuf5BDWKzjzg==
X-Received: by 2002:adf:f812:: with SMTP id s18mr15379565wrp.380.1584961345811;
        Mon, 23 Mar 2020 04:02:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s7sm22412914wri.61.2020.03.23.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:02:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 954D2180371; Mon, 23 Mar 2020 12:02:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next 5/6] libbpf: add support for bpf_link-based cgroup attachment
In-Reply-To: <20200320203615.1519013-6-andriin@fb.com>
References: <20200320203615.1519013-1-andriin@fb.com> <20200320203615.1519013-6-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Mar 2020 12:02:24 +0100
Message-ID: <87wo7b49mn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Add bpf_program__attach_cgroup(), which uses BPF_LINK_CREATE subcommand to
> create an FD-based kernel bpf_link. Also add low-level bpf_link_create() API.
>
> If expected_attach_type is not specified explicitly with
> bpf_program__set_expected_attach_type(), libbpf will try to determine proper
> attach type from BPF program's section definition.
>
> Also add support for bpf_link's underlying BPF program replacement:
>   - unconditional through high-level bpf_link__update_program() API;
>   - cmpxchg-like with specifying expected current BPF program through
>     low-level bpf_link_update() API.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/include/uapi/linux/bpf.h | 12 +++++++++
>  tools/lib/bpf/bpf.c            | 34 +++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h            | 19 ++++++++++++++
>  tools/lib/bpf/libbpf.c         | 46 ++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h         |  8 +++++-
>  tools/lib/bpf/libbpf.map       |  4 +++
>  6 files changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index fad9f79bb8f1..fa944093f9fc 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -112,6 +112,7 @@ enum bpf_cmd {
>  	BPF_MAP_UPDATE_BATCH,
>  	BPF_MAP_DELETE_BATCH,
>  	BPF_LINK_CREATE,
> +	BPF_LINK_UPDATE,
>  };
>  
>  enum bpf_map_type {
> @@ -574,6 +575,17 @@ union bpf_attr {
>  		__u32		target_fd;	/* object to attach to */
>  		__u32		attach_type;	/* attach type */
>  	} link_create;
> +
> +	struct { /* struct used by BPF_LINK_UPDATE command */
> +		__u32		link_fd;	/* link fd */
> +		/* new program fd to update link with */
> +		__u32		new_prog_fd;
> +		__u32		flags;		/* extra flags */
> +		/* expected link's program fd; is specified only if
> +		 * BPF_F_REPLACE flag is set in flags */
> +		__u32		old_prog_fd;
> +	} link_update;
> +
>  } __attribute__((aligned(8)));
>  
>  /* The description below is an attempt at providing documentation to eBPF
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index c6dafe563176..35c34fc81bd0 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -584,6 +584,40 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
>  	return sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
>  }
>  
> +int bpf_link_create(int prog_fd, int target_fd,
> +		    enum bpf_attach_type attach_type,
> +		    const struct bpf_link_create_opts *opts)
> +{
> +	union bpf_attr attr;
> +
> +	if (!OPTS_VALID(opts, bpf_link_create_opts))
> +		return -EINVAL;
> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.link_create.prog_fd = prog_fd;
> +	attr.link_create.target_fd = target_fd;
> +	attr.link_create.attach_type = attach_type;
> +
> +	return sys_bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
> +}
> +
> +int bpf_link_update(int link_fd, int new_prog_fd,
> +		    const struct bpf_link_update_opts *opts)
> +{
> +	union bpf_attr attr;
> +
> +	if (!OPTS_VALID(opts, bpf_link_update_opts))
> +		return -EINVAL;
> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.link_update.link_fd = link_fd;
> +	attr.link_update.new_prog_fd = new_prog_fd;
> +	attr.link_update.flags = OPTS_GET(opts, flags, 0);
> +	attr.link_update.old_prog_fd = OPTS_GET(opts, old_prog_fd, 0);
> +
> +	return sys_bpf(BPF_LINK_UPDATE, &attr, sizeof(attr));
> +}
> +
>  int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
>  		   __u32 *attach_flags, __u32 *prog_ids, __u32 *prog_cnt)
>  {
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index b976e77316cc..46d47afdd887 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -168,6 +168,25 @@ LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
>  LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
>  				enum bpf_attach_type type);
>  
> +struct bpf_link_create_opts {
> +	size_t sz; /* size of this struct for forward/backward compatibility */
> +};
> +#define bpf_link_create_opts__last_field sz
> +
> +LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
> +			       enum bpf_attach_type attach_type,
> +			       const struct bpf_link_create_opts *opts);
> +
> +struct bpf_link_update_opts {
> +	size_t sz; /* size of this struct for forward/backward compatibility */
> +	__u32 flags;	   /* extra flags */
> +	__u32 old_prog_fd; /* expected old program FD */
> +};
> +#define bpf_link_update_opts__last_field old_prog_fd
> +
> +LIBBPF_API int bpf_link_update(int link_fd, int new_prog_fd,
> +			       const struct bpf_link_update_opts *opts);
> +
>  struct bpf_prog_test_run_attr {
>  	int prog_fd;
>  	int repeat;
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 085e41f9b68e..8b23c70033d3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6951,6 +6951,12 @@ struct bpf_link {
>  	bool disconnected;
>  };
>  
> +/* Replace link's underlying BPF program with the new one */
> +int bpf_link__update_program(struct bpf_link *link, struct bpf_program *prog)
> +{
> +	return bpf_link_update(bpf_link__fd(link), bpf_program__fd(prog), NULL);
> +}

I would expect bpf_link to keep track of the previous program and
automatically fill it in with this operation. I.e., it should be
possible to do something like:

link = bpf_link__open("/sys/fs/bpf/my_link");
prog = bpf_link__get_prog(link);
new_prog = enhance_prog(prog);
err = bpf_link__update_program(link, new_prog);

and have atomic replacement "just work". This obviously implies that
bpf_link__open() should use that BPF_LINK_QUERY operation I was
requesting in my comment to the previous patch :)

-Toke

