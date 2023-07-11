Return-Path: <bpf+bounces-4803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBBA74F95B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB34E1C20E21
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426CB1EA6E;
	Tue, 11 Jul 2023 20:52:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E3171D9
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 20:52:05 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1BF1AE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 13:52:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so102071581fa.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689108719; x=1691700719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcPcOsaH39p0NQAtc5LelPrHysKQuq9AyQ3tZrzLiP4=;
        b=RgHasEk3OSZ5kgIU3jkEHSSVRxpe90mAN+NHJP07Jtlvqeox1Ixc+qWwVk0Ut9RNIb
         UDrt4XBrMpLcMREfLHlTpBNa0LgCBG1tnMTaUsd9gtg8QorNa67i38Qd8O9Gwd3/dgkv
         VMXR3iE/Ay0OkudJZ1xEw0aO9IRaf4d8CnrCNlE2xMJ7A72NeXEVfOo/gs4CWqBsktXD
         7UdWD1OAfFhA0Gd/oIe3LaCIv/rZlLhgdXxfFddRdOeeQnPRHmoqZoKTCxKdQFXa/8z9
         xWzS5+2CmXuEvO9DYTyK5wB8w8DNzLYY9wz7+Rr2piJn0zDgOtUDyurkBHyXJo5AMBXo
         r7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689108719; x=1691700719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcPcOsaH39p0NQAtc5LelPrHysKQuq9AyQ3tZrzLiP4=;
        b=YHAsYhRMm3nabEjiS40iWKJs3UZLrcTT6Y+KBpMYP/15XIgUQUroxoO0E/16mLTbE6
         K7YaLHwBlcQASGUvRU88ke0GFib4THzjVqoqFsr1Nv6Kj8xdgt3G9lyoQmw6XCcU9vd4
         o4DIAFkgneHwrcl92CWGLAjnBLyEflfDrkyBP/ujEvVxofK9X1gm+vCazLKmRZEjtyp5
         vwZmVqrxapVu0tQsLUW5Gpt05oeQSGA9Fo2aZEn/6R0P3hzgw/Nv9+bE8mi3BK2ERbdo
         +joXOS531Ck+ZwFPPX7J+CabGb2lAlGYg9mURFvYC71n5DUvLo9Y6ClXe1JyaKbZXscN
         Jx/A==
X-Gm-Message-State: ABy/qLbzJegoOe07yjlclNHf3LBHAtEjKfPm2zXtrNb1YX4faOJsgcf5
	paMkpoDxEtv9fG+27YvmT4FqV4yJMDGpOLZFoxR6/YyYMrY=
X-Google-Smtp-Source: APBJJlHPNrEKEgt+6CNSsqbZV67GyEiYfBnkOwJA/dHA0Q/MeIx3nLZ0n4wByvBMTWYBq1sk5zkAnhFdTXHaZcbQXw8=
X-Received: by 2002:a2e:979a:0:b0:2b6:f21c:2c46 with SMTP id
 y26-20020a2e979a000000b002b6f21c2c46mr12907800lji.53.1689108718752; Tue, 11
 Jul 2023 13:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711175945.3298231-1-davemarchevsky@fb.com> <20230711175945.3298231-3-davemarchevsky@fb.com>
In-Reply-To: <20230711175945.3298231-3-davemarchevsky@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 13:51:47 -0700
Message-ID: <CAADnVQJ0YOn4UwOy3svSnE7gwWxRZ2kB3urktsVC5GpYhn9pxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Introduce internal definitions for
 UAPI-opaque bpf_{rb,list}_node
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 11:00=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> Structs bpf_rb_node and bpf_list_node are opaquely defined in
> uapi/linux/bpf.h, as BPF program writers are not expected to touch their
> fields - nor does the verifier allow them to do so.
>
> Currently these structs are simple wrappers around structs rb_node and
> list_head and linked_list / rbtree implementation just casts and passes
> to library functions for those data structures. Later patches in this
> series, though, will add an "owner" field to bpf_{rb,list}_node, such
> that they're not just wrapping an underlying node type. Moreover, the
> bpf linked_list and rbtree implementations will deal with these owner
> pointers directly in a few different places.
>
> To avoid having to do
>
>   void *owner =3D (void*)bpf_list_node + sizeof(struct list_head)
>
> with opaque UAPI node types, add bpf_{list,rb}_node_internal struct
> definitions to internal headers and modify linked_list and rbtree to use
> the internal types where appropriate.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h  | 10 ++++++++++
>  kernel/bpf/helpers.c | 23 +++++++++++++----------
>  2 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 360433f14496..d5841059fd2f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -228,6 +228,16 @@ struct btf_record {
>         struct btf_field fields[];
>  };
>
> +/* Non-opaque version of bpf_rb_node in uapi/linux/bpf.h */
> +struct bpf_rb_node_internal {
> +       struct rb_node rb_node;
> +} __attribute__((aligned(8)));
> +
> +/* Non-opaque version of bpf_list_node in uapi/linux/bpf.h */
> +struct bpf_list_node_internal {
> +       struct list_head list_head;
> +} __attribute__((aligned(8)));

We typically use _kern suffix for data structs that
mirror bpf.h structs.
Let's use it here as well instead of _internal.

