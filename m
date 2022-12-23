Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E2654DE0
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 09:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLWItr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 03:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiLWItq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 03:49:46 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082F275F8
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 00:49:43 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-45f4aef92daso59298347b3.0
        for <bpf@vger.kernel.org>; Fri, 23 Dec 2022 00:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsKOO+9Gg8GjRSoTnmJpIDC+bsH19yynb8zABVDWuvw=;
        b=TdAvrxJ8hXmPA21h2WM2Rjhasbd5Lbsb9pmQOGuRfmyX0ZXIDg6Fmw+MhUqr258FP1
         4KKcq16aQ13XWydUQoj9rb+bNlnOqj+R352hux0MueGun45BcvoG0kkEhmw7bGA9YPEP
         PfJlyUS7Ta1NgoI2o5zv1qpMjbTmAb6sHKYCR7FSr45Jb+9ZPUg+bNXheoMRk1TTHYGI
         rcNZX2Q+dNP05pvZVw50rfb7eDQGANVmX/fulXlku2CeYnUPr5usIdXVRNGVqHnFytr4
         2OAOq3LHUgyW7mmsiw7Y9z+mQOYd6NPpa7/5fTcZ57anbPUkepbp9wIguXO6HXU5rMOE
         nDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsKOO+9Gg8GjRSoTnmJpIDC+bsH19yynb8zABVDWuvw=;
        b=h79ogNFsWyyj/f9ty9CxnKwLfT+O5wvUsyhcTf1cImpDmFMhGSCI6u03jSSfeIWUUo
         Tty1QIraylvFDoniTX0NTsi3MmdtlqcSvWAZSEMhdFfp0kBm+pIi9liFV1HOqU4mnciX
         LYFQo7qqP+cyGPmD6lPi/L8a/D8qlRl9zi4igWvpbskQ7EDC6V5xCMftYRBu/Ec3bAQj
         SHJ3duKdKj0HE1ln5VujVuPY9lV534qiTVMWOE+wB+q2VielZWxYlcI2uOaPxobvOZ3O
         /j0VBnw3/DONlQQ+vlv3Qz8m3PCHnKybmwAmRBV1e7hYlT33IjwppysW+7iOVATYo+VF
         7gtg==
X-Gm-Message-State: AFqh2kpGDT4FKV11tXLTBFxy1H/keuNBTdAeyWPeorT55DsLNa0bD7ji
        b7ZNrmiWlt1jIx8BohIJOlBvjgPzIbS0KAVO/eQ=
X-Google-Smtp-Source: AMrXdXuVSHXkRRPmOnk9W1BzZmX+S3DYGnHdh9SJkTntHxaTAypagNFWSA1AVTIfdscASEFayqiHuo9fKbTh38uevRg=
X-Received: by 2002:a81:10d3:0:b0:36b:fbd0:2f6b with SMTP id
 202-20020a8110d3000000b0036bfbd02f6bmr750234ywq.387.1671785382448; Fri, 23
 Dec 2022 00:49:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:62d1:b0:31f:ff92:c4f with HTTP; Fri, 23 Dec 2022
 00:49:42 -0800 (PST)
Reply-To: sanderlow1101@gmail.com
From:   lowe sande <sanderlow038@gmail.com>
Date:   Fri, 23 Dec 2022 08:49:42 +0000
Message-ID: <CANsHkn49Xpt4pFH6vD4Lg8yWO0-Ap3aHZ2AkRd8HcfNW1K38DA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGVsbG8gZGVhciwga2luZGx5IHJlc3BvbmQgdG8gbWUsIGl0J3MgdmVyeSBpbXBvcnRhbnQuIHRo
YW5rcy4NCuyViOuFle2VmOyEuOyalCDsuZzslaDtlZjripQsIOuCmOyXkOqyjCDsuZzsoIjtlZjq
sowg7J2R64u1LCDqt7jqsoPsnYAg66ek7JqwIOykkeyalO2VqeuLiOuLpC4g6rCQ7IKs7ZW07JqU
DQo=
