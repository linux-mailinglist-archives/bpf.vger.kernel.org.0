Return-Path: <bpf+bounces-1627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC171F3F6
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F7281935
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133423D78;
	Thu,  1 Jun 2023 20:37:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9523D58
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 20:37:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7698E
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685651856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b01Oazl7JiDVcsGgKiDqMrNKj5SCQRNAK+gkRLeif6k=;
	b=KWvk4mR5l6apZ7gNDNk8yY1JH16dVv21TZce5RZDbPJFXOszuTtN2rJAtZTvGYRuBSjZE4
	0JmsGc3hWmeodpnSaib9B1mNBinIHoATvl6jyvCNWNsVObDVZFG6uKUQKhpRXHZzj8SgR5
	Ys2q4m2098Dek4CK6C22bunoWO1J6Zw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-tri92UAEOeCZx5PwkOHLMw-1; Thu, 01 Jun 2023 16:37:35 -0400
X-MC-Unique: tri92UAEOeCZx5PwkOHLMw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-514b19ded99so943768a12.0
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 13:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651854; x=1688243854;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b01Oazl7JiDVcsGgKiDqMrNKj5SCQRNAK+gkRLeif6k=;
        b=Z3L53Vpr+SXp0fkrX98j8Jv+kiU0Pbl5eCOF3qIcoPsBJmc1hMAgYWfxIDGtgrMkD8
         Ix2nyE3k/YPngG/Q2GiNXeQoABkQ700uReun1pvLDQ8XfwWKlnQhL5Wh8kfB5pIWspXI
         Cco3tKo2cRNrwsCA3/F+FioAoM9u9L3YT8Wma2DPuwApVTgib64zfJuM1Komx20Z9KOd
         twUu4j9N6ko2FHDlgOXJspUEQyl36AAZq2ixCPw50ZWiUSNJVTdjz0NR+luX+J/0KT3a
         wUhQj9u25x9JiBjCU1Ft+LVu2X2AWdHE8FbyLYdfKvayVJhHo1Y2/WMNlbNVeCG3rwp9
         YiKw==
X-Gm-Message-State: AC+VfDxFl1EJV1V23rikOGFNLtpJZzb3ezUYl/aYQZe8RNCw6sqSXrfk
	xNB+6TQmzQ5wluGiTePG1uEMDQ9i7UX2KzbKYVamG9Nj7DzDREAjc5xk9VkUqiL0+iFufcQaRLK
	hvWEt/zxv9wEY
X-Received: by 2002:a05:6402:b13:b0:510:f6e0:7d9f with SMTP id bm19-20020a0564020b1300b00510f6e07d9fmr674166edb.13.1685651853674;
        Thu, 01 Jun 2023 13:37:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71ozjVU3xqn0gn++2aKcpPYxcQQGLLFK2gjuaeWIusLV2sAeqSsdfjZyQ8uqGurbHFeJOZJg==
X-Received: by 2002:a05:6402:b13:b0:510:f6e0:7d9f with SMTP id bm19-20020a0564020b1300b00510f6e07d9fmr674148edb.13.1685651852754;
        Thu, 01 Jun 2023 13:37:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7d586000000b005153b12c9f7sm2207288edq.32.2023.06.01.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:37:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8A388BBD28D; Thu,  1 Jun 2023 22:37:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>, Tariq Toukan
 <ttoukan.linux@gmail.com>, Daniel Borkmann <borkmann@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Cc: Jesper Dangaard Brouer <brouer@redhat.com>, Tariq Toukan
 <tariqt@nvidia.com>, gal@nvidia.com, lorenzo@kernel.org,
 netdev@vger.kernel.org, echaudro@redhat.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH bpf-next V2] bpf/xdp: optimize bpf_xdp_pointer to avoid
 reading sinfo
In-Reply-To: <168563651438.3436004.17735707525651776648.stgit@firesoul>
References: <168563651438.3436004.17735707525651776648.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 01 Jun 2023 22:37:31 +0200
Message-ID: <87bkhydilw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> Currently we observed a significant performance degradation in
> samples/bpf xdp1 and xdp2, due XDP multibuffer "xdp.frags" handling,
> added in commit 772251742262 ("samples/bpf: fixup some tools to be able
> to support xdp multibuffer").
>
> This patch reduce the overhead by avoiding to read/load shared_info
> (sinfo) memory area, when XDP packet don't have any frags. This improves
> performance because sinfo is located in another cacheline.
>
> Function bpf_xdp_pointer() is used by BPF helpers bpf_xdp_load_bytes()
> and bpf_xdp_store_bytes(). As a help to reviewers, xdp_get_buff_len() can
> potentially access sinfo, but it uses xdp_buff_has_frags() flags bit check
> to avoid accessing sinfo in no-frags case.
>
> The likely/unlikely instrumentation lays out asm code such that sinfo
> access isn't interleaved with no-frags case (checked on GCC 12.2.1-4).
> The generated asm code is more compact towards the no-frags case.
>
> The BPF kfunc bpf_dynptr_slice() also use bpf_xdp_pointer(). Thus, it
> should also take effect for that.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Thanks for fixing this!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


