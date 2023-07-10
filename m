Return-Path: <bpf+bounces-4644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E874E081
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E1B28130D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867916417;
	Mon, 10 Jul 2023 21:58:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761F156D5
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:58:25 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8FDA
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:24 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-767b6d6bb87so229928485a.2
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689026303; x=1691618303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1jSr9YWA3hBZ37krPSSfrcga/fNnyp1P2GV4GvNeWE=;
        b=gn+3upERU76we9kXLRRmCBPtfsRsPDTAcOdbAwxsnNr5lF1xpEaNzXiFHXP1hwyLY9
         HryzSDIfaVVzFSwb4gsoAZsDPWAqxZxJOXoYj8WU0lJoR9mOsLgjfJ1YebNvJSPvn9v4
         uVu0mbFQLuLizkWbrg/YKKDr7E4nPcHTED0hNIO9zQb27cEo5MV8y85qOXirdbVrIj/i
         SKYxp535O6SkzOqAARvd85StG2iGTsAwhNz6LbOjjDDImxXqnd9gjiHgsEDqjJ2rlLeV
         jdb5NdNdAJMeOFoiCOL36RA6PbDSCZzvd630dj4mjnbJGTirgSzAiAHRMPhtX0E8YuRJ
         T8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689026303; x=1691618303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1jSr9YWA3hBZ37krPSSfrcga/fNnyp1P2GV4GvNeWE=;
        b=H9BOX5eNfRuas/QFJsLHeWb0/nXcloKlzxwlPprOABLj+pf8ZICVrY7+tGqlKjVpp6
         dYYwu+oodypQE49ZVuLyRiuWUqiRH4IcUVXr0HIaKRpm6mcCkPcEo3HrJkAl1IBoeQab
         Js6BHlOosrn53mAvR+gjR6RJb39BFMiJi0YOHWzzWUyF0DSnsURK4mAXRJdxG9VNdeB7
         c4MFq8nOTdLZVyPStbo2JbwWdrv/UtilNluUfETCID2SPI4nyStnpmx50JdFh1kGF9A8
         tc07u6TcyjfggCePdw8pRraAwXutUf46sROZSVYyLeQJx4ne4hR/n+Fm/1NaT4msTSp+
         2iFQ==
X-Gm-Message-State: ABy/qLb828obZ9qlGC9mS9muYvVd9vBEa2JQarXzSQiVYexfvDAHt8fj
	hYbyC7Od6BcLZTXkCkbonJ2HOhObq7Caxo2Xjo8=
X-Google-Smtp-Source: APBJJlFjlRdPqScLU8h8QDMeOWgTfAWPL00Y3wHE6OGnlXarsQb7K1avpuyW6s6vDZusRf8zgfM1HA==
X-Received: by 2002:a05:620a:424a:b0:765:a7d9:7085 with SMTP id w10-20020a05620a424a00b00765a7d97085mr12928876qko.51.1689026303521;
        Mon, 10 Jul 2023 14:58:23 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id pa36-20020a05620a832400b007676658e369sm295380qkn.26.2023.07.10.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:58:23 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 0/1] Specify twos complement format for signed integers
Date: Mon, 10 Jul 2023 17:58:18 -0400
Message-Id: <20230710215819.723550-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Following the precedent of the Intel architecture manuals, it seems
important that the ISA specify the format of the available data types. I
hope that this is a useful submission.

Thanks for all that you do!
Will


Will Hawkins (1):
  bpf, docs: Specify twos complement as format for signed integers

 Documentation/bpf/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.40.1


