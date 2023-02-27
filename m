Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0BD6A3DE9
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 10:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjB0JKy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 04:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB0JKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 04:10:41 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A41C17E
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 01:02:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h3so5608413lja.12
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 01:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CenbL9OK64wkFX9+zr58jnk3Hw/xUrv6MVpLYEUvK8w=;
        b=N8GvLtbznykXT26RsTC8C6gskMHqn6dcoMjn3fZMtn9mWVIlziVPtXzo9iZAfnVIoM
         GhrWB7o95q2NhbiKrbperZ0EIq3Bva4O0OUdf8msGXoU6pyTGzgLv3ckFzpr8SKtnBnj
         mPAOOI9kWKOAsMKGi3qI29/7CNJ1roZJEOIPMP5wSnd8KlpF836LNypCtg27/al8HowR
         BwYC62pjGE9VqiKuSWQbPTqsDk+wtFSPT3XuUZ8fLc9R5fPWvEov4/D8Zfg0zaXlntni
         rLoqHNZ2965Uz+hmnhLOFlDylZjIc2CRZra13acmh4yeup7X2d73q8ECaCSZc5gw++5m
         UUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CenbL9OK64wkFX9+zr58jnk3Hw/xUrv6MVpLYEUvK8w=;
        b=RWDhdjNM8a1qStLMMmWL+3Q4Tc5ChOJaWBbhqORV12uvkgQSKZsfCXnziybRLWspwF
         mVKmvOif+2+LX75GBxZxVdKSIi4rDzjWvOhz+OHcX4iwTgHkWoyXb1rSvkYSeRsLwFcd
         tvFuVBDjCfnnwe2c4+Q/36eGAjktrdi0WxfRyac/gA1xtsaEuw8D32/cvZk08nk10AtN
         xdrve5SWkdRtIj2TUpCvYIo78O3jXDciH2ndpL/gttaPfc8EZOg7gzO+hMiFELv8ilkR
         gUgrant8ZJy7GrOZ4ZyLAkuKRM9qgBbIQMZpqtaQyK8QUoVDZITERoq376S8+bfrq3cu
         aomQ==
X-Gm-Message-State: AO0yUKWSJOH7/3ELwrhLb8LIZ7k/Z+g3fzXHiqzjPZFouWy/eg0qa36K
        Ikl+tjBaNJczZYk9r99J6QtikIvXX7DKemlctJgTerzvBCRqYLHjX1E=
X-Google-Smtp-Source: AK7set8TRKs5gc7+HWzfD6dDvFn/d9hQgtft4jF2rVjtnVZxL9nDrqMhGWV5QVuPQP3FIOI4/M4Buqx1oBXBdbdQn8c=
X-Received: by 2002:a05:651c:2223:b0:294:efb6:1cea with SMTP id
 y35-20020a05651c222300b00294efb61ceamr3284061ljq.5.1677488544117; Mon, 27 Feb
 2023 01:02:24 -0800 (PST)
MIME-Version: 1.0
From:   Anton Protopopov <aspsk@isovalent.com>
Date:   Mon, 27 Feb 2023 10:02:13 +0100
Message-ID: <CAPyNcWeAc6qPnxGQVTh1D1WEhLNocDt-=OTOGsXi0D9=Sj6RYg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] XDP Multi-Attach
To:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the tc BPF links patch [1] will be merged, a similar concept for XDP
links may be used to allow multiple users to live next to each other. The
purpose of this topic is to discuss design and how to better sync with libxdp.

[1]  https://lpc.events/event/16/contributions/1353/
