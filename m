Return-Path: <bpf+bounces-1920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E77723BD8
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8352815C9
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE29453;
	Tue,  6 Jun 2023 08:32:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A10290EC
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 08:32:52 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B819B7
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 01:32:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso5118392f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686040279; x=1688632279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHNi1vjqssMwbBRBUlKuIVNnk+fejXUw8W1G+4gTVIo=;
        b=XuoX7bEae8YcFAtTfR7dAhr4jy2tvOtG5qpbe4i+OtclO3d/tIDY6s9x9VuaXgzfhN
         OhiC8AZwZalKBu55WpNTRBZtms6l+y3daC4W88moPF0/BYIuSoZTjyjAxaK+YlwT+qBS
         8qDIqWi8Jjyicl5lrzHcaLwEXFkI/Ltgqx2spXseZfXzgJ9PTW78kmdrKmX/VWlkKrSE
         54e4QfSoA/r3XtVezshF4IVPAvhx+ZyKhBrCaxovzLhXRnK5A5xSPqtvsv+fQpJfQKeb
         ZzGz258onKUDA14ATiU+w3z6t7iFsW48jaPSDUAAR5Ttnw9u6IUYmfFf3ZU9uQi8BVs2
         J8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040279; x=1688632279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHNi1vjqssMwbBRBUlKuIVNnk+fejXUw8W1G+4gTVIo=;
        b=NOBh7aL00F3OwY0bhOmB/TPuhcIzjwsA6W9h3ZbBW+Xb2kSEr2Uw2bPRxNe3pnSBSt
         S/lE5eyRRhXiC3Q7ub7op3JKWlC1meVTiYMj4lgGMyQhonYmmNhpSPdtI/2hRd9t7qci
         JEZH7FQPBwCsfJEVb7kdCyLxIkUvDAUM3k/Kvt3Rl7RZKBDbdGHmOrh8QjcAPcQNQt6u
         cMqrWG5SbxdgRve6KhNSxm+PKqdLuh2T4QmFo73xchDwMmQJXTgYXx/jxkFtmraQQJFi
         mYaHBYa4/W6qrylWcStR1dYrlz51Mo+cMRUPsCQJYPvCxETAk0Bm5gBPSzjZ5cNtqW9q
         xG+g==
X-Gm-Message-State: AC+VfDwXzRCoYjHSyg25k6D5TNhZwbYaidRTJ0z8NMMVhBGq8sSYp07q
	NgQP9H4kYNXmM2NGKp6T/z6s++eRbn90yElTCL8=
X-Google-Smtp-Source: ACHHUZ5gKI7N7v5KvhDfbt5tOc4XeWWIxIyNhcFFLgjEqC+whv6lzXrLT4uv46Y6rQC24nVUAMdEEg==
X-Received: by 2002:a05:6000:11d1:b0:30a:ea5c:a97c with SMTP id i17-20020a05600011d100b0030aea5ca97cmr1224466wrx.18.1686040279383;
        Tue, 06 Jun 2023 01:31:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c228600b003f7ec896cefsm206656wmf.8.2023.06.06.01.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:31:18 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:31:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: eddyz87@gmail.com
Cc: bpf@vger.kernel.org
Subject: [bug report] selftests/bpf: specify expected instructions in
 test_verifier tests
Message-ID: <ZH7u0hEGVB4MjGZq@moroto>
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

Hello Eduard Zingerman,

This is a semi-automatic email about new static checker warnings.

The patch 933ff53191eb: "selftests/bpf: specify expected instructions 
in test_verifier tests" from Jun 21, 2022, leads to the following 
Smatch complaint:

    ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_program()
    warn: variable dereferenced before check 'buf' (see line 1364)

./tools/testing/selftests/bpf/test_verifier.c
  1363		*cnt = xlated_prog_len / buf_element_size;
  1364		*buf = calloc(*cnt, buf_element_size);
  1365		if (!buf) {

This should be if (!*buf) {

  1366			perror("can't allocate xlated program buffer");
  1367			return -ENOMEM;

regards,
dan carpenter

