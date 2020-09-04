Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED4025DC80
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgIDO4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgIDO4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 10:56:23 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF1C061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 07:56:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z13so3333313iom.8
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ORI5ML3L/W9cUJMK9DOu1RwphEPRbFAjkrEVN5IxHJk=;
        b=d/eRqzbuQeV60E7w8rM0ZymJaspSvlai6gF+e7TXHY7XimUBsl3rZwfskZlbhUgDi6
         9RqAN7zqDxpMplz/08KjEb4JYPDR56hdSeaqUTelJ1LUFYlnjPh56uqTdgNjEKDwZGSh
         F1G96y6SfX+6yBDCbT1ixuk+K90a7W7QF6PATPDXeDhaxsftmbmM8BsNKm1suCI6OT3f
         9q356dIKuwNmpVU3kleqrZtloyciXZu90miT+tBPCVi2hpiMrXaUOtbfT+kk0yhpY8Az
         bVnW+8yTFUcS3XbOaZUlhHY96zXqrpURac1PH7V3tCgvJylmXbd9x9nc692A/79bUMPa
         nlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ORI5ML3L/W9cUJMK9DOu1RwphEPRbFAjkrEVN5IxHJk=;
        b=F1TGpJPEs5AK+1j+EEUSCIv61hcBYSihxnjKjlkowOK8i2HiWR94QeA91hopgF2vuL
         KtWwPi61/cHuA465OcjU/H3mEHhAFA/EAaJLZUaDIJJGrYW2lEENjIMTjDTssiMXo0a8
         MIgKzlIwG7uIThmj4uXGTLVL1HVDX3RDH+/MJcUJrv9/7Ppool9FCHvpgiSc2rOAGKH4
         LJH+crltzvCDKaKAtYVQXYjoosiNwcNuy8RhfmZL5RTL7V+0vqyIRIL5Rlz6S6D0zbCb
         BiUx25/AqjIq5dYk2/Y+LwHvPETRuVIj2ZBZQUJ8u2tODQ4KKXiCO02cyivLczbs5NeO
         V3nQ==
X-Gm-Message-State: AOAM531X/sZgYUjzcfoJRJ0G87kiVXrVKdqw3P3Ak0fK9+TB55zpJ1Wy
        yVZR88xHEWqw93cKfFHWkSxC97ST63mWMEnMlzJYOtjGypHpzuvi
X-Google-Smtp-Source: ABdhPJzv/LkCJYU8YYwZTBHrcrw+S56AfpnVnmCsVgq/BR65kk6zfBLUdofn/PwUG589w1tJ04hBp+v2de7n7F8/tnY=
X-Received: by 2002:a02:b70c:: with SMTP id g12mr8386548jam.62.1599231381580;
 Fri, 04 Sep 2020 07:56:21 -0700 (PDT)
MIME-Version: 1.0
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Fri, 4 Sep 2020 16:56:10 +0200
Message-ID: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
Subject: HASH_OF_MAPS inner map allocation from BPF
To:     bpf@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

Judging by [0], the inner maps in BPF_MAP_TYPE_HASH_OF_MAPS can only be created
from the userspace. This seems quite limiting in regard to what can be done
with them.

Are there any plans to allow for creating the inner maps from BPF programs?

[0] https://stackoverflow.com/a/63391528

Best regards,
Borna Cafuk
