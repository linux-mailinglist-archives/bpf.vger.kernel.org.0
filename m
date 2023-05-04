Return-Path: <bpf+bounces-1-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB726F732F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0893280E06
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130FEED0;
	Thu,  4 May 2023 19:32:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4AA948
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:32:19 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98465FF9
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 12:32:17 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-61a4e03ccbcso8239416d6.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683228737; x=1685820737;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsRgewL0pjvnw1tfHXZ5MTL8XAAkGTgsfMc5BFkEpXc=;
        b=W5qjfos73mL8ih0TV/FvzvepsEgrjyVWTgpNTX3MTENGVdJN54PVB8PRKtiqE7CFsM
         ftJ9xpMei2sLWDHgmu9xW8hKz5QH728dVYAzil3iYrK1c7iwdRe62kofVcRlPDQYoBEf
         gRd72tqzIXxgoPeXE49eScEqUVw5O5LdjV/18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683228737; x=1685820737;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsRgewL0pjvnw1tfHXZ5MTL8XAAkGTgsfMc5BFkEpXc=;
        b=hKVAD/tkibhfZfZoieV0AGGRAHQO8Ob2Gf3+NHaYJooOLFIFOzfMSNFbzXj0mgJAzu
         M/pLZ1RrqHRxneJ0QJ2bl3QI5OadNbvsAi1n8xl9EKyDcQMsdjyZJKl/hbnm06rh4+Xr
         UDfr9NWUSg7JoG3zV5CRIlo4TGHj3bT5BaMt19vtbpEj/cIv3DWLViHXmyEmGdqxsbjy
         pihd2ZblLd1D7fGWL+NvCGEBXKzVZS0fyHX10yKYoxEK5vTCabj7VFboF/fjR2+gVsD+
         G0hG3EGL0mbOupTs+Cnla7pI1ooIoAA7+1frJedU2+/k573ntoqidUSc3Y4wOBSpuQAV
         Uq1Q==
X-Gm-Message-State: AC+VfDwcdUHWPRxd23QfySBwrHEKUcXR8iZPJLKph30ffmeyPvPvO+oO
	2H4PE3vEGsBDxPlejDBWFdWVTMYj7N09ztaBU3s=
X-Google-Smtp-Source: ACHHUZ6RvaGKhvIqstRK/dn+tlxKt46D6O1J6BM6fIPXw211mwn21lZ371MS8Drgd3HMSVvGktpiIg==
X-Received: by 2002:ad4:5d6c:0:b0:5ef:4ae4:4da6 with SMTP id fn12-20020ad45d6c000000b005ef4ae44da6mr20598884qvb.31.1683228736883;
        Thu, 04 May 2023 12:32:16 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-132.dsl.bell.ca. [209.226.106.132])
        by smtp.gmail.com with ESMTPSA id i5-20020a0cf105000000b0061b5a3d1d54sm3640998qvl.87.2023.05.04.12.32.16
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 12:32:16 -0700 (PDT)
Date: Thu, 4 May 2023 15:32:14 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: bpf@vger.kernel.org
Subject: [ANN] bpf mailing list migrated
Message-ID: <20230504-repave-oppressor-82955e@meerkat>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, all:

Hot on the heels of netdev mailing list migration, we have completed the
migration of the bpf mailing list to be running on the new subspace system at
LF.

There is no action required on anyone's part and everything should work as
before with only a change in the Received: headers.

There will be a small interruption in archiving later today as I migrate it
to the new source of truth, but there will be no lost messages once the move
is completed.

Best regards,
Konstantin

