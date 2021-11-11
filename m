Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4444D6E9
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 13:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhKKNAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 08:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKKNAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 08:00:19 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F9C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 04:57:29 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r12so23803905edt.6
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TpTcTcivucgwkiyqkj1zzJWU3hB8dDNMbilNVwfOU0A=;
        b=Q6gcGmwDLnpCf1Jic1BfdfQO8Xuo5wIEkdUpDkVccJRnMCy1gP+JTTd0D5ugopf4qf
         PAkJa8yOkOKeWq/sTmcBI+1zGbtaMazYNt8fmN9ZbCIZKyVlsErU2t6lgz7VWL1wlhKW
         nnOMjLuu/IPYzrHXu7Bs+A92U3Nv8RjXBym4+afFic0W1eSXBaV/zxqAV6pU0IeKagM7
         t2lY7Vu/a73/szpbKK5LhVCLSROxQ2UGGNNt1v80YrEFKmQsIXq3UlK4BlRM8reHh7O3
         GQILVRhxeYj5bQVEACdctlon2ycAZWH8dcK4pGTXANDyUMHeW9Gb/WL3fJ7lwSpyy/6S
         u6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TpTcTcivucgwkiyqkj1zzJWU3hB8dDNMbilNVwfOU0A=;
        b=LbLc4qCGAN/vCUUKP44J8M9+B58d+NCvSqUrTZ/vyklXXQcGISwouLB0EWsARajiqa
         kyVIYT15PwvUDSMDzno3aelIQ2YGG+gvAq2GR7yLSrX9CTmXF7QyBL69dJar+lBS5C+N
         2uHPQSjMe8k8qbTAaUGU25MnOYKxQ/fhah7fGBFsyvtzHUKsBhnmhWZFRNbr9Jb9lruS
         I4HECaoTo0kVwKJ/45Aj1ipp7e6B2LeGihAh1IG0w0Dc+DRFp/z9v2hqAAg6oHA1Dufo
         5NMP8MKvFUg9VAcuvEiFV8KlAFy7k/Pl3UqLySPTkM3Tfu6Nz2vke5Kh6NdaStzbOkkg
         o54A==
X-Gm-Message-State: AOAM531CYYyK2eNvrQ7QbnYTxAIWTz1kmmlkDiFuJUU29eQyi3h3fxxc
        IV1AQJMlFKz5iZCrBHNQWAoTt8qlZhwKNDqxPNY=
X-Google-Smtp-Source: ABdhPJwFaUZ7XyVSUlJmKABlTKiZB1hswikYtk6NZlLq3VblW7Ofz8aKUkh5xzNYrCe24AildRYk8G1egqf7K+nM49o=
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr8996551ejc.196.1636635448252;
 Thu, 11 Nov 2021 04:57:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab4:a806:0:0:0:0:0 with HTTP; Thu, 11 Nov 2021 04:57:27
 -0800 (PST)
Reply-To: kathrynh566@gmail.com
From:   Kathryn Hensley <kiyomorikinzo@gmail.com>
Date:   Thu, 11 Nov 2021 04:57:27 -0800
Message-ID: <CABPcjqkUuOnQbLxk1xXgBXv-_kCnWrOQSxB=GmcHqaCpC1Uujg@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

5bCK5pWs55qE5YWI55Sf77yMDQrmiJHmnInkuIDnrJTkuqTmmJPmtonlj4oxNzkw5LiH576O5YWD
55qE5aSW5ZWG5oqV6LWE77yM5aaC5p6c5oKo5pyJ5YW06Laj77yM6K+35Zue5aSN77yaa2F0aHJ5
bmg1NjZAZ21haWwuY29t5LqG6Kej5pu05aSa6K+m5oOF44CCDQrosKLosKLkvaDjgIINCg0KDQoN
CkRlYXIgU2lyLA0KSSBoYXZlIGEgdHJhbnNhY3Rpb24gdGhhdCBpbnZvbHZlcyB0aGUgdHJhbnNm
ZXIgb2YgJDE3LjkgbWlsbGlvbiBmb3INCmZvcmVpZ24gaW52ZXN0bWVudCwgaWYgeW91IGFyZSBp
bnRlcmVzdGVkIGtpbmRseSByZXBseSB0bzoNCmthdGhyeW5oNTY2QGdtYWlsLmNvbSAgIGZvciBt
b3JlIHNwZWNpZmljIGRldGFpbHMuDQpUaGFuayB5b3UuDQo=
