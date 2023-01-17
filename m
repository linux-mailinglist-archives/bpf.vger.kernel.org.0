Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA566DF56
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjAQNuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 08:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAQNuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 08:50:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F723B0E8
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 05:50:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so30614012wrb.11
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rfJtGPsUo0GVXrtw9E8O3Sl6p2Hghsgai1NrXEcl3dw=;
        b=B8JrSj8a+WtfulyjvlChcCAkbRngU/CGxrYK7HB7WZgAciUCoOeEIwk4ArGZOdQVEZ
         cbKgoipWi82J239xd8TQslAq47TIUkJHFV9JttdKXWYK1yaB/FYrSgq682207I1QDfCA
         4+1ITcy3DiQHSSjOE1ZEDEx4LC8HX0ZAsn5d+gpkuVDRFJAICfRLi8vAd5q4OuAPVqwp
         vUhOsQmOtgOirZoONi6a//U/qC3fbW0Dh0j80EKK/ZAOK3MdE0fgK7pF88NZdgtDPoWM
         B0KvAxXy6OPC3jSleUwoHXviKlxKeId33G7U9UVjXtoNKWcFuoyTfK247ZXfp/kxqzfO
         tklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfJtGPsUo0GVXrtw9E8O3Sl6p2Hghsgai1NrXEcl3dw=;
        b=akFDC9NYgDEL1WHRUkV754jKsyivVilwEteDSZDi+SoFqsyBelOTsJVcuaiwEpglsU
         apcQjmwKQVZkRwrfNxBI6/wO5CIfiMAK/JS+lcjmVy7JvCRelHX2ylA+qcVDgEo3G1xl
         lcQVp18NE1GqP8cyJTrelei1a80eH7/wLg4D3FYsff2dt0uQQLowMhn73FYmqg8bqlh2
         w5H+gxtAv7rJgElOC4KPyFXvBkW+6ek91dQU2/FzQxdkUc0+vtkU14f9B3KHGumEwGY1
         cyrz1pMTxS18UF5saYQ/OPjv+CvAUtQvUvVCc2HzAjz+3unLRV/bYT18nGADO5CYvgU6
         +90Q==
X-Gm-Message-State: AFqh2kqkmXT78OlLODZWYxTy0Y5mKVThbtMN0zUCzpFpsooeoMXGAiT2
        yq9Um4hNvp2Ei/OQC9kFvK/joWa0vDs=
X-Google-Smtp-Source: AMrXdXv2NBSKocikkPjs5Q7EXyhkoD+BFZk7ZcAXXdqBFuj/igHduLzaRaKgr71NEomQkETU+Rrueg==
X-Received: by 2002:a05:6000:12cf:b0:2bb:4b40:2d1b with SMTP id l15-20020a05600012cf00b002bb4b402d1bmr2836013wrx.61.1673963403219;
        Tue, 17 Jan 2023 05:50:03 -0800 (PST)
Received: from DESKTOP-53HLT22 ([39.42.178.198])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b002bdd155ca4dsm14530252wrs.48.2023.01.17.05.50.02
        for <bpf@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 17 Jan 2023 05:50:02 -0800 (PST)
Message-ID: <63c6a78a.df0a0220.73ea.e0a5@mx.google.com>
Date:   Tue, 17 Jan 2023 05:50:02 -0800 (PST)
X-Google-Original-Date: 17 Jan 2023 08:51:38 -0500
MIME-Version: 1.0
From:   halduncan472@gmail.com
To:     bpf@vger.kernel.org
Subject: Any Drawings for Estimate?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=0D=0AHi,=0D=0A=0D=0ADo you have any estimating projects for us=0D=0A=
=0D=0AIf you are holding a project, please send over the plans in=
 PDF format for getting a firm quote on your project.=0D=0A=0D=0A=
Let me know if you have any questions or if you would like to see=
 some samples.=0D=0A=0D=0AWe will be happy to answer any question=
s you have. Thank you=0D=0A=0D=0ARegards,=0D=0AHal Duncan=0D=0ACr=
ossland Estimation, INC

