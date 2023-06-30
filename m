Return-Path: <bpf+bounces-3799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB447439A9
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4CB2810CB
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD2134A5;
	Fri, 30 Jun 2023 10:35:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7012B6B
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:35:49 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812C54491
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 03:35:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso15420805e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688121329; x=1690713329;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyX/U+jzAyZeK7ZjJACS7hegFla1Kf4ZqRAYH1DR2RY=;
        b=KMtrn9rhAXzlW7DVmhT8W3YRXezcY4QG/7kFfmMCSQFLTOZPLyrlkz2Ep7MPvN7GUh
         PMgKjHL5ZLBZc2J+qjBT79lRABgQrSF5pZ+UNoM6+zkS679uQtS963oDizpdt7Ci9lbu
         4FOLFqCVI6Oj7DgqB1MfjasDAtQY9SFr5VX1CIjYwo+ERMTcNfnYW983QJaqxrMzhuPS
         vimQTNAROMDevqcevkFcNCnLA5n9K40Zp85x/e3RigroQ4m37V383oBwr0DFk0UI+ox8
         oJsukFk7OLEa7Rk1kHQHnGXEa/aYp4Fsycht6xCDS3BmNDc6VBhfdIb6s0xvSibYJI1y
         5v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121329; x=1690713329;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyX/U+jzAyZeK7ZjJACS7hegFla1Kf4ZqRAYH1DR2RY=;
        b=Ss3U9j74x/UtDpSOngeIMBpCiq2lFqFNKbZQepCxvlnrl76upqhW4oIXJRgiTmWX8T
         21YvyrIbfj4RK/Q2IEmpO99S3GqEWP3wkFQrzrzdPf5q/FcSlMXVg4XXcf2DXJ9Fwmk9
         1YgOjJuOUwjxsKN+kJzEu3JczhON4dDNMVCNj1dZ+4ofAuiXqKaG4vOb3Ye2Gu0GubHU
         Fi9+mZLpNGgQPHly2g2P/B8V5K5LB1IfgI+tI5NO8qJ5NO1Z+UBmsyHNJLRU+gB2NZ36
         Z4APzenZQB9V8lPcCyjvgtL6ZDP0ElCA44fE5curZ6zt9xjn1Cx2aPSFzQT3bm5kD7yt
         47RQ==
X-Gm-Message-State: AC+VfDz3yHtd+TgqIDztnPpJ64lOama9/pk52tfKB9tt0ZZmpj+30cXh
	hlNM0Emvuao/nKnjJrRUYD6DIQ==
X-Google-Smtp-Source: ACHHUZ5L/cr7bdCUw3csTTRtmQlerpU0biPTQx95Vp/GHIImFEPfZFArZ+jNM337SjHTzEC0fKYIkg==
X-Received: by 2002:a05:600c:2201:b0:3fb:a6ee:4cd3 with SMTP id z1-20020a05600c220100b003fba6ee4cd3mr2413341wml.16.1688121329407;
        Fri, 30 Jun 2023 03:35:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbc90e030csm698308wmc.37.2023.06.30.03.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:35:27 -0700 (PDT)
Date: Fri, 30 Jun 2023 13:35:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: andriin@fb.com
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Enforce BPF ringbuf size to be the power of 2
Message-ID: <9c636a63-1f3d-442d-9223-96c2dccb9469@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Andrii Nakryiko,

The patch 517bbe1994a3: "bpf: Enforce BPF ringbuf size to be the
power of 2" from Jun 29, 2020, leads to the following Smatch static
checker warning:

	kernel/bpf/ringbuf.c:198 ringbuf_map_alloc()
	warn: impossible condition '(attr->max_entries > 68719464448)'

Also Clang warns:

kernel/bpf/ringbuf.c:198:24: warning: result of comparison of constant
68719464448 with expression of type '__u32' (aka 'unsigned int') is
always false [-Wtautological-constant-out-of-range-compare]
        if (attr->max_entries > RINGBUF_MAX_DATA_SZ)
            ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~

kernel/bpf/ringbuf.c
    184 static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
    185 {
    186         struct bpf_ringbuf_map *rb_map;
    187 
    188         if (attr->map_flags & ~RINGBUF_CREATE_FLAG_MASK)
    189                 return ERR_PTR(-EINVAL);
    190 
    191         if (attr->key_size || attr->value_size ||
    192             !is_power_of_2(attr->max_entries) ||
    193             !PAGE_ALIGNED(attr->max_entries))
    194                 return ERR_PTR(-EINVAL);
    195 
    196 #ifdef CONFIG_64BIT
    197         /* on 32-bit arch, it's impossible to overflow record's hdr->pgoff */
--> 198         if (attr->max_entries > RINGBUF_MAX_DATA_SZ)

This check used to be inside bpf_ringbuf_alloc() and it used be:

	if (data_sz > RINGBUF_MAX_DATA_SZ)

In that context where data_sz is a size_t the condition and the
#ifdef CONFIG_64BIT made sense but here it doesn't.  Probably just
delete the check.

    199                 return ERR_PTR(-E2BIG);
    200 #endif
    201 
    202         rb_map = bpf_map_area_alloc(sizeof(*rb_map), NUMA_NO_NODE);
    203         if (!rb_map)
    204                 return ERR_PTR(-ENOMEM);
    205 
    206         bpf_map_init_from_attr(&rb_map->map, attr);
    207 
    208         rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
    209         if (!rb_map->rb) {
    210                 bpf_map_area_free(rb_map);
    211                 return ERR_PTR(-ENOMEM);
    212         }
    213 
    214         return &rb_map->map;
    215 }

regards,
dan carpenter

