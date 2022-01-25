Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88AA49BA83
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379374AbiAYRjR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbiAYRis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 12:38:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BCEC061753
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:38:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m4so32209841ejb.9
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=a9DMXpY512K46gZjExH5r1SImRcDwJo0q7ygzaLfVLY=;
        b=enfCrepSo5+x3mT4StEcRyib6XtIgvubZMZUZEb/3XKqnRawsttNEUaig8DnpR5nUK
         rJgv0hzV1S79ZD4gBYf+cu0A90xIw8MCRX9Wj1K/LxsfadQS0VerUZYbeCBq1OPkkmnX
         2YlSRPiKvqJY0Sj8WjBcbKTkmVWEuOAR2QH8u4WB+MZB5J6btZNIkg78uRZF/vd0boQa
         2CVDCZsuchW40ExTKYIoBL/HHJdK0wexDLMi2QlHLjFPCT4xcEV6niEflLveF2wTszWE
         bV2BVz2ozEb7uNQJ037F9OyD3td8qhLMMCQ00Cs/DSpcdQHyHggY3yHRbOxtb9D7/H+U
         rvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a9DMXpY512K46gZjExH5r1SImRcDwJo0q7ygzaLfVLY=;
        b=BWkE/oKb8fIY4j8qTmUMhkLfg3Rg8JDXl+OZIr19OKVNeu2O4NYDSuEosoB3rmrMgi
         IyO8imErU8XVHz64YzgzCsSs2j9yG7DY2jnHNHw354pFuRUD3XylXh0tLWIKOnL3Fx7e
         n6gS3nvY9UHrcLBhWpnAzxmFEEyoy18VlARTY//x1GuFK4Ol0dP/JtHyE0/3mFnEdyfe
         5tvk9ThMVOkTHa8Y+W2WbQ6zLHdAVBYhYjzUPSjP0omuZG3nQ7MBfl3IcJgu9n1xp+S5
         vrsObvDSb2wSyX1Kq+ugxVIYRTFQMi8JbHqV0qh7bYHFw2n5nJJE03O8q1PyMs9S1Q9z
         Z/QA==
X-Gm-Message-State: AOAM530r3dS9zcvzrlu8SDp6QtAH0rk1soaBHndyX5nbbmI6dz/oJGDu
        yBLWLZPA+VK6CF0K5BveIr/jvfrqaisIq73EhvyoLyeYsZ3PNw==
X-Google-Smtp-Source: ABdhPJyb1ioW6i0hSz48Ldpg2n7xo+WrSv3c7VMQtr9cn23YSxm/QepdqVnFV4U0y3T+PDYmKr22OxqUgjTPNQElxJY=
X-Received: by 2002:a17:907:3f84:: with SMTP id hr4mr17457275ejc.443.1643132325935;
 Tue, 25 Jan 2022 09:38:45 -0800 (PST)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 25 Jan 2022 09:38:34 -0800
Message-ID: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
Subject: can't get BTF: type .rodata.cst32: not found
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi

While developing Cilium VTEP integration feature
https://github.com/cilium/cilium/pull/17370, I found a strange issue
that seems related to BTF and probably caused by my specific
implementation, the issue is described in
https://github.com/cilium/cilium/issues/18616, I don't know much about
BTF and not sure if my implementation is seriously flawed or just some
implementation bug or maybe not compatible with BTF. Strangely, the
issue appears related to number of VTEPs I use, no problem with 1 or 2
VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
experts  are appreciated :-).

Thanks

Vincent
