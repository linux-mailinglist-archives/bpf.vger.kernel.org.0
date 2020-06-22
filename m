Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708FB203D4C
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgFVQ7j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgFVQ7j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 12:59:39 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA40C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:59:39 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b15so9408273ybg.12
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BY/ZgEIoOPGfwyXtVhHdeuuWSP6vauQ79dBB27Baggk=;
        b=axIOP1iLoNpCJ4GgcazKPtQ2jyDtGSzMLo8DVPU0wANU/t1Fiq0c/O3epLQDY80HPB
         L1Scq2m7Bp/EokM7W+LlpRe55d9IZEiqtX0rxzUdtp/Pa6o8E2g7yncSJSvKBOc8FJSt
         CO9kFRxEyL2yMOFrLflL/aUoX1d5fgn2nL55rP1q6gV74HveVvk3k7wqNxNJ1ZSV9mzv
         g6uenxVy1LgNcwRPGswn8xcineX3Zb7yLnwfawOZnwbW43FJOIttoaXLi4g4dKqgLzya
         QtQdt2NglLX8T+PU7wol279/2WkK+74D0QNfL+SmAxhlquPvDoAJJsvQpfydH1KgA9UM
         5flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BY/ZgEIoOPGfwyXtVhHdeuuWSP6vauQ79dBB27Baggk=;
        b=bdwnOQMBzSLkOGzxViaskjYc70MsBKqTjUlqPP1zdu9TGT99+rdxdXXu1UGtz9vwLT
         l7YRkQGzUNylm78fOTtcDM9lst0KKxm+3O8ol3Gyay/g7klM5dS7gcWzeIcHIGDKdGjU
         NnszSfzut1G5khpZaqKb/aXNJ8BSu+WrXGOimi3uqxjLGgjBY8TqtnDRgWER21xwUdm1
         atChLN2yO57Gv76K/tOL0fpI5yvZbtWiPBXBDhQ8PANGs9L+g5vP341yJQMD6eq3l7fC
         QthwnLrNjceaR8+eL8KjrsRQ3GWg5GHF+MQBcElLalpjVQCXBdRJKH5P3fjW78jwZ8j1
         JpxA==
X-Gm-Message-State: AOAM531ZFInaASoeKaGNWsA+E2xHm80ufkZgCykT93vHIjss23TLonFW
        gtWl0POBkd8L/dzfYCVsS8l+eocvA3031sQGUFDzWt/8Wys=
X-Google-Smtp-Source: ABdhPJy4wEImtsEbSsEJfasuhD04l+a1myf6iu34lqyTJvAhAFqPfNkyTeKLRhhxDe8EcYObm8pU72B3IjpaQbzJrGs=
X-Received: by 2002:a25:c60d:: with SMTP id k13mr28444022ybf.506.1592845178113;
 Mon, 22 Jun 2020 09:59:38 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Vijeev <abhishek.vijeev@gmail.com>
Date:   Mon, 22 Jun 2020 22:29:27 +0530
Message-ID: <CAHhV9ES1aUO-Zfpz6uCnFhY3Rgi3ZS1pn4ztz2iXYFO-KX75BQ@mail.gmail.com>
Subject: Checkpoint/Restore of BPF Map Data
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I've been working with the CRIU project to enable CRIU to checkpoint
and restore BPF map files.
(https://github.com/checkpoint-restore/criu/issues/777).

A key component of the solution involves dumping the data contained in
BPF maps. However, I have
been unable to do this due to the following reason - as far as I'm
aware, Linux does not provide an
interface to directly retrieve the key-value pairs stored in a BPF map
without prior knowledge about
the nature of data stored in it. To explain what I mean by 'without
prior information about the data
stored', let's take the example of a BPF map that stores key-value
pairs in the form of a hash table
(BPF_MAP_TYPE_HASH). The only way to iterate through all the key-value
pairs in this map is to use
BPF_MAP_GET_NEXT_KEY. However, if I start with a lookup key that
exists in the map, I will only be
able to iterate through the key-value pairs that occur after this key.
Therefore, I must start with
a lookup key that does not already exist in the map, so that
BPF_MAP_GET_NEXT_KEY returns the
map's first key. However, information about the nature of data stored
in the map is only available to
the application programmer, and it will hence be difficult for CRIU to
guess a key that does not exist
in the map.

I would therefore like to discuss the possibility of extending Linux's
BPF API to provide easier
access to the data contained in BPF maps, in a manner that works for
all types of maps and is
potentially future-proof for other kinds of maps that may be added.

As I currently understand, this problem stems from the fact that
reading and writing to a BPF map's
kernel buffer is only possible using the BPF system call. Therefore,
functionality that allows
reading from and writing to the map in a manner that is agnostic to
the nature of data stored in it
(similar to tee and splice for pipes) would enable checkpointing and
restoring BPF map data.

Do let me know if anything I have written is factually incorrect and
also if there is something I
can explain more clearly.

I look forward to hearing the kernel community's thoughts on this.

Thank you,
Abhishek Vijeev.
