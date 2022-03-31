Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354964EDE64
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiCaQIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiCaQIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 12:08:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A210E2F72
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 09:06:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h23so431121wrb.8
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=sRI5XlQuVhbQpVno+gQjd5SDdPnY78rewgDrJvAnuiU=;
        b=gVPuEA9UBv70eo/1cRhRoPvHCjoYXRFvnKN/ECCBr7sttPucGtGZp87rSYtqC8vrnJ
         AMeMCHdcx3IXhz7bj/EAgAJ0Sd1MXX6VJbPSWOMygZYl843D/q9EjMZnIpABxP2vyaD1
         DsrmZciVR6HfrRPFskNPMcviuqzsoCYixNgFVhao9QaXb/KMKUQZ7QaqGf1JHerS2ZmX
         Xx4STNwf3jyKkJ91BHQ8gQTjATjeP4JEPfZtSEySzHBD8EXVj5zf1WsntDtMOMCkWHNr
         vwZhgb7ZanyBD5nyWumu11uy56nMlxow9TwXNxgjip03kLDApCuvcO457MnAkNhKGFGV
         Q12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=sRI5XlQuVhbQpVno+gQjd5SDdPnY78rewgDrJvAnuiU=;
        b=7u7Nv3pCcp3Hd3Fy+cpyADB/PuxAqD/Iu41WELQouPbks/QAYIsOKlRY6S+yA7qnUu
         30m13TVm9c/GQ1ri91TMhzG4Nb5W65yIOGjBMGBSK67/nN8oOoh0WfoH98Y+rk42h9qc
         cx1pO6luOxut/txRscu2I2eJiAwzK+xk141/ct+J8xfvc6wfmhUHSBHAubXpqQ3IqATG
         nbeY1q1/XjCjOw9PugVtyqcCyv7w1L03LVWkZyLiCNaeXhv4eLCm/oaIA0tboQtZTCMQ
         h8FXKqYxSTaius+0woZ3pcBCQf3A4raz1k2sR0h7rPdYslA9pev23+y07xEjFdA8vB6D
         hT5g==
X-Gm-Message-State: AOAM532Tuq/4TkrdlN2voOT7BJwiClM4Q3THDvQYyKXW0g31Z2agkgf7
        qUJ11T4cLzHpxcdHZJCEH/f2jrpy9mxRJA==
X-Google-Smtp-Source: ABdhPJw8A66xnWS5ja7VNEshzhSMNI4nXSlG0ilRsG1ITeS/scQIY5X1OI5FF5inH+YHuv9e9ndDwg==
X-Received: by 2002:adf:fac8:0:b0:203:fb08:ff7 with SMTP id a8-20020adffac8000000b00203fb080ff7mr4565427wrs.648.1648742813533;
        Thu, 31 Mar 2022 09:06:53 -0700 (PDT)
Received: from DESKTOP-R5VBAL5 ([39.53.224.185])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b0038cda9f92fasm8499272wms.0.2022.03.31.09.06.51
        for <bpf@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2022 09:06:52 -0700 (PDT)
Message-ID: <6245d19c.1c69fb81.6baa0.4560@mx.google.com>
Date:   Thu, 31 Mar 2022 09:06:52 -0700 (PDT)
X-Google-Original-Date: 31 Mar 2022 12:06:52 -0400
MIME-Version: 1.0
From:   moyadreamlandestimation@gmail.com
To:     bpf@vger.kernel.org
Subject: Estimating Services
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0AMoya Rhett=0D=0ADreamland Estimation, LLC

