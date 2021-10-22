Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34C437C40
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhJVRwN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhJVRwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 13:52:13 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A2C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 10:49:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g6so8759144ybb.3
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ywF0qohEImyzsx3mnnoXhrBE2ZYpYwGwROZHC7I1e1s=;
        b=R0Sr2JIEAq1FZjrd/ogXMvfbtuUOg5futlKZrR7mLMk7FfUFrxZYK9qJtnjbFuy7ma
         EWbSfWWwIad/8w3zo0TObARkkmqdUWSIaSnHu/7g6yaqfuV/cKs/0pPEVEuyVs8o9fEt
         VVqoxAIQoDEXv4VmEm+f5gpKMl37e8WiSeoabizxuYubXzqpdoZbCjh6xbQ/LThI+oss
         GflrGoEjFymDR8ohHOJGaNzhDlD2P/P41OwsO+MpOuF8g1SK9foleq9HTR4VHXNF+EJt
         9NAp2ujzzLqN74OHDuLQq+m1v/0NERNKAxtloIZclZPm7tg4cDXKcSfvu3hKGTmlCOie
         IEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ywF0qohEImyzsx3mnnoXhrBE2ZYpYwGwROZHC7I1e1s=;
        b=3jTom80WMxF+Y0m2SQjJUYXd2DNiLRmQU238bjy9hS3UfmIN3N1NhtMXVfkcJUjYty
         d6Zy7DE6An8QKLqSl018wXocWybM1Ihu/JDDdzs2x25ke32ZTSPZ3w83q3UyKszlUbKO
         6Iix9HUTfjzQoMWjqzl0NSvwmFhZYEINS3Hnej9KQX2V9GPAL+di+3ucaW/OxJknUrUJ
         dv3W6oWPdUkEY+R/VWxuH/2HFKpexw6crmKzEXfyzlH+bZKGcKZdR0UhEXZiCazEBpg0
         xN6gZef47Uo3Y3WA13CZMHunEQFF1q92XBoYllSljmKX8feD5ASlAj26kGhiZBHSb1fq
         kvHw==
X-Gm-Message-State: AOAM5316DQZ8end+12OP+/Ha1jRnEd8Co1VqbTtOGMqIApB9AfY5OveV
        fmeDDV+w26Gitil18ZKzRiHgiZ4243tbYSjrPeo=
X-Google-Smtp-Source: ABdhPJwo9gJXL1n7u18bGphkWn7tag5/rjkh6CvfSOnGRVgcNC3Hl4hdcc/VJFfUTjfEWV6kb73aTLZZDkkdBjxmCzI=
X-Received: by 2002:a05:6902:154d:: with SMTP id r13mr1480891ybu.114.1634924994552;
 Fri, 22 Oct 2021 10:49:54 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Oct 2021 10:49:43 -0700
Message-ID: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
Subject: libxsk move from libbpf to libxdp
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey guys,

It's been a while since we chatted about libxsk move. I believe last
time we were already almost ready to recommend libxdp for this, but
I'd like to double-check. Can one of you please own [0], validate that
whatever APIs are provided by libxdp are equivalent to what libbpf
provides, and start marking xdk.h APIs as deprecated? Thanks!

  [0] https://github.com/libbpf/libbpf/issues/270

-- Andrii
