Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E0611457
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ1OSo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1OSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 10:18:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738D1DC802
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 07:18:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so13223269eje.10
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0zn0xqVzW5C09h2DUdKKSNPsrQtUCxuCg1ERHP5ZVxM=;
        b=VnuD5uz+9ocTWCTNX90yR1kgzB5y/87lWjaO+aurAQ15veI/cmaku5881TKujD4biZ
         81afzRat9y5IO1PTUPdpQklp+IbFyZ8O7eqwZKqRFAl1ujLnlNGPStdGDvHVVM1zDfOZ
         izPJ3b4RWNIVm1KMEr7g8x8S7+/p3IY++xGvDjW3VYXYiqijOFL/PkpqfqXKE/JR9NRS
         DKOHQveJpSXk2l9YE1tYCSn+GJjETsKFZvszcK8ZltJhEkAZurCJFzzTKIjSJylV/dnY
         w9fTn/OF13M/cPAOcv2N1lAwJHfl3n2+G+lRRHqTIZK8pEO/4XOdFh4kdd+EnNTDErbg
         XuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zn0xqVzW5C09h2DUdKKSNPsrQtUCxuCg1ERHP5ZVxM=;
        b=TZYJxKBmJt5IyFBPot8noi9BSvVeHGgGOIsuE6Ow9hrnonHD80r+2v2MKmZ3xC8wWA
         fhUmvF+I5/b2xGiVR8ne59A0p2y2K6JpCk3c9mizA/dUVqoMo5yABVh/pK3oVx1aoogU
         5WHG/xNdJ6J3d9I9zkdFbuPhzkQojnWRoObXnFAugBsCmBXULSzhj7Hl78/bh5xjSH7R
         ZJUJ/uaZnzyuektaCzZ5AwoYTtginn1ON9FI6Y5lqfTABCZjp6v04UShQECoeznXMhx9
         5mSI0bNU+ba7/jSvJ79S55q3gBWhljLrXtmv5wM8daNUuBVF0jNrWdN/qLO8dONWG+qy
         K51A==
X-Gm-Message-State: ACrzQf1Z/cNQ7c/4Az6R256KPidUMyuSU+RH+vP0aAnFkMRAe+GSBOk3
        E+v72/UMVxfsMTh3yeAo51QxYKqslAS2E6K3Z3m8uvsqzlY=
X-Google-Smtp-Source: AMsMyM5fAp1GiAlaFzSZvk+4S0YzqIlKSEMLlj6A3xXml+p0KVD7cDuHonvs5ho8c1pCBnU9zxuYYhkwVwqgbs8Z9ls=
X-Received: by 2002:a17:906:db0c:b0:77b:7d7d:5805 with SMTP id
 xj12-20020a170906db0c00b0077b7d7d5805mr48937102ejb.726.1666966721738; Fri, 28
 Oct 2022 07:18:41 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 28 Oct 2022 10:18:29 -0400
Message-ID: <CAO658oUcnKPHZvFO+-2tDuDny9spYg_9AftkuqLL=cH5S-s4kw@mail.gmail.com>
Subject: libbpf not properly detecting support for memcg-based memory accounting
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It appears that while using libbpf 1.0.1 on a 5.10 kernel, libbpf is
not properly recognizing a lack of support for memcg-based memory
accounting. This is happening in Google's default Kubernetes
environment (GKE). The error message we receive is:

```
libbpf: map 'sys_32_to_64_map': failed to create: operation not permitted(-1)
libbpf: permission error while running as root; try raising 'ulimit
-l'? current value: 64.0 KiB
libbpf: failed to load object 'embedded-core'
```

We were able to fix this issue by manually bumping the memory rlimit,
leading to the conclusion that the detection of memcg-based memory is
not functioning properly, and therefore libbpf is not handling this
manual bump as advertised.

Environment:

```
Linux ubuntu 5.10.123+ #1 SMP Sat Jul 9 14:51:14 UTC 2022 x86_64
x86_64 x86_64 GNU/Linux
```

Thanks so much,
Grant Seltzer
