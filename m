Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF7603953
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJSFnR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 01:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJSFnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 01:43:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550E84E844
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:43:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so15932436pls.4
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LqTBGSDpn6t4eseDx69LqNdMR85prYAGb37ZMBME9A=;
        b=eQa9H8ilyy5ahOLIbHvp06IITOpybzAUyaVyCRxzPYce2DcvLsy0EcjQeuRAygVX5K
         76cKPLlVcLLN+EXSIAgNbKFmY6+4DBxH61nQU8MpV7xpLTGpNxsTk7pfFXZLTGvw0JmK
         oGdBV/w+9SnQvrmDBRs0lYzArZ62SxoZ25lr0O+tz2R8dbXyGTdHQDkzjh/qzbys4Cfp
         z5VQ93XT/t3mQXrmlMhimpXLISwwPyOeqCTRqpHHJuCXST2/Vx5FK65nTxMEden7Jvtn
         ePxn3YjUb5BXWekzz6AKMrCFrCsFCN4xoWHsuvu3zWa0CdaEBeISH5Rik7UI6gKdM3zo
         qPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LqTBGSDpn6t4eseDx69LqNdMR85prYAGb37ZMBME9A=;
        b=whw4DEhZ7YJpfUsPfGLX+Srx16rzy9+gkzgYkochGdIuHjgbYnHFcoI076TbHD7S3y
         YGMe/mIbLA7KsoV1Lw5J0CcJ9ypoIYUE4zMQsKJemmGBiKLlEvVe/UT3qBdwafk+CO1Z
         HhUto8IagUBqWD/PF7KwG+e/xv/HU0UD3HqRSc+fVD7dhAI4DS2iiBMnRhluKDk8RkDW
         QzBqjn/dX4W4R3cyVey1Gs4KeXXZuZBAK5SdnQiwbU/raR3EHNmAvm4g9lVAg93zRjSe
         r4MKNJ0RXKbU+hFK6aPk7g4vvgNhyotcQBANP8pWX/rtcMiubtg7/+WcOB+F9WyIO3ad
         5+tw==
X-Gm-Message-State: ACrzQf1knpzdZSbV0EGjnwpcpcImua1dC5qrXxVy/CGjLMFwWHHQ+B/n
        Rs6nJSLBVYXoD/ymxCARYrvlnzn6VUZBRQ==
X-Google-Smtp-Source: AMsMyM4kSqD76oy6im05SjyZktBHBp3Ao/f4n9j6680qeoiZ5js2IPD7trfR9LTqnee4YpVM/Dixsw==
X-Received: by 2002:a17:902:d2d0:b0:183:6545:39c7 with SMTP id n16-20020a170902d2d000b00183654539c7mr6607766plc.16.1666158194708;
        Tue, 18 Oct 2022 22:43:14 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b00179988ca61bsm9607506pla.161.2022.10.18.22.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:43:14 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:12:57 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 06/25] bpf: Refactor kptr_off_tab into
 fields_tab
Message-ID: <20221019054257.ly6eoskl7xjgayao@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-7-memxor@gmail.com>
 <20221019013526.ziiksjif63frt6nn@macbook-pro-4.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019013526.ziiksjif63frt6nn@macbook-pro-4.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 07:05:26AM IST, Alexei Starovoitov wrote:
> On Thu, Oct 13, 2022 at 11:52:44AM +0530, Kumar Kartikeya Dwivedi wrote:
> > To prepare the BPF verifier to handle special fields in both map values
> > and program allocated types coming from program BTF, we need to refactor
> > the kptr_off_tab handling code into something more generic and reusable
> > across both cases to avoid code duplication.
> >
> > Later patches also require passing this data to helpers at runtime, so
> > that they can work on user defined types, initialize them, destruct
> > them, etc.
> >
> > The main observation is that both map values and such allocated types
> > point to a type in program BTF, hence they can be handled similarly. We
> > can prepare a field metadata table for both cases and store them in
> > struct bpf_map or struct btf depending on the use case.
> >
> > Hence, refactor the code into generic btf_type_fields and btf_field
> > member structs. The btf_type_fields represents the fields of a specific
> > btf_type in user BTF. The cnt indicates the number of special fields we
> > successfully recognized, and field_mask is a bitmask of fields that were
> > found, to enable quick determination of availability of a certain field.
> >
> > Subsequently, refactor the rest of the code to work with these generic
> > types, remove assumptions about kptr and kptr_off_tab, rename variables
> > to more meaningful names, etc.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h     | 103 +++++++++++++-------
> >  include/linux/btf.h     |   4 +-
> >  kernel/bpf/arraymap.c   |  13 ++-
> >  kernel/bpf/btf.c        |  64 ++++++-------
> >  kernel/bpf/hashtab.c    |  14 ++-
> >  kernel/bpf/map_in_map.c |  13 ++-
> >  kernel/bpf/syscall.c    | 203 +++++++++++++++++++++++-----------------
> >  kernel/bpf/verifier.c   |  96 ++++++++++---------
> >  8 files changed, 289 insertions(+), 221 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9e7d46d16032..25e77a172d7c 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -164,35 +164,41 @@ struct bpf_map_ops {
> >  };
> >
> >  enum {
> > -	/* Support at most 8 pointers in a BPF map value */
> > -	BPF_MAP_VALUE_OFF_MAX = 8,
> > -	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> > +	/* Support at most 8 pointers in a BTF type */
> > +	BTF_FIELDS_MAX	      = 8,
> > +	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX +
> >  				1 + /* for bpf_spin_lock */
> >  				1,  /* for bpf_timer */
> >  };
> >
> > -enum bpf_kptr_type {
> > -	BPF_KPTR_UNREF,
> > -	BPF_KPTR_REF,
> > +enum btf_field_type {
> > +	BPF_KPTR_UNREF = (1 << 2),
> > +	BPF_KPTR_REF   = (1 << 3),
> > +	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> >  };
> >
> > -struct bpf_map_value_off_desc {
> > +struct btf_field_kptr {
> > +	struct btf *btf;
> > +	struct module *module;
> > +	btf_dtor_kfunc_t dtor;
> > +	u32 btf_id;
> > +};
> > +
> > +struct btf_field {
> >  	u32 offset;
> > -	enum bpf_kptr_type type;
> > -	struct {
> > -		struct btf *btf;
> > -		struct module *module;
> > -		btf_dtor_kfunc_t dtor;
> > -		u32 btf_id;
> > -	} kptr;
> > +	enum btf_field_type type;
> > +	union {
> > +		struct btf_field_kptr kptr;
> > +	};
> >  };
> >
> > -struct bpf_map_value_off {
> > -	u32 nr_off;
> > -	struct bpf_map_value_off_desc off[];
> > +struct btf_type_fields {
>
> How about btf_record instead ?
> Then btf_type_fields_has_field() will become btf_record_has_field() ?
>

I guess btf_record is ok. I thought of just making it btf_fields, but then
bpf_map_free_fields (for freeing this struct) and bpf_obj_free_fields (for
freeing actual fields of object) gets confusing.

Or to be more precise I could name the struct btf_type_record,
but the member variable record in all places.

> > +	u32 cnt;
> > +	u32 field_mask;
> > +	struct btf_field fields[];
> >  };
> >
> > -struct bpf_map_off_arr {
> > +struct btf_type_fields_off {
>
> struct btf_field_offs ?
>
> >  	u32 cnt;
> >  	u32 field_off[BPF_MAP_OFF_ARR_MAX];
> >  	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
> > @@ -214,7 +220,7 @@ struct bpf_map {
> >  	u64 map_extra; /* any per-map-type extra fields */
> >  	u32 map_flags;
> >  	int spin_lock_off; /* >=0 valid offset, <0 error */
> > -	struct bpf_map_value_off *kptr_off_tab;
> > +	struct btf_type_fields *fields_tab;
>
> struct btf_record *record; ?
> The '_tab' suffix suppose to mean 'fieldS table' ?
> Just 'record' seems clear enough.
> Or
> struct btf_record *btf_record; ?
> if just 'record' ambiguous.
>

Ack. I think just 'record' is ok.

> >  	int timer_off; /* >=0 valid offset, <0 error */
> >  	u32 id;
> >  	int numa_node;
> > @@ -226,7 +232,7 @@ struct bpf_map {
> >  	struct obj_cgroup *objcg;
> >  #endif
> >  	char name[BPF_OBJ_NAME_LEN];
> > -	struct bpf_map_off_arr *off_arr;
> > +	struct btf_type_fields_off *off_arr;
>
> 'off_arr' should probably be renamed as well.
> How about 'struct btf_field_offs *field_offs;' ?
>

Ack.

> >  static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> >  {
> >  	if (unlikely(map_value_has_spin_lock(map)))
> >  		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
> >  	if (unlikely(map_value_has_timer(map)))
> >  		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
> > -	if (unlikely(map_value_has_kptrs(map))) {
> > -		struct bpf_map_value_off *tab = map->kptr_off_tab;
> > +	if (!IS_ERR_OR_NULL(map->fields_tab)) {
> > +		struct btf_field *fields = map->fields_tab->fields;
>
> will become
> struct btf_field *fields = map->record->fields;
>

Ack for this and the rest below.

> [...]
