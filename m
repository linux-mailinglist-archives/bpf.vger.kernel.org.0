Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3618145CB34
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 18:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhKXRlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 12:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhKXRl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 12:41:29 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FBBC061574
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 09:38:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r25so13911510edq.7
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=K7kU/3v8PDN/H55Go4hCp9T1eZlcziQMopaRZ4NNkwU=;
        b=VB6+EleCFueq99eiEnEmz4ji2hpAiIky+PsZTrSIKLC0alyPvFaWN9b/vd3BGc/ttu
         8Y73TfkIyvhihPDXxes4wTWYi7S54OnJ3c79HXq/Z9RBfmJ7P21K545kpf7SNXO6mbhV
         xg1FyFURbZb9HF8sxaa3lRb7mdk7+CffP54zk4fca4wLXUSAx58qR68JUDBjgee5QWbk
         vJhccmguo5pw16Co/KP6/32+BE5TLA9emel9MKHnNC2QtR5CRTVyI+Blt0prpAgy38x6
         RqqLP+xouBeGv8vfz9PqQ+yftuslPiMXFSvQMoQqTgOw7bWBQNe+7rwhLlNrEVFaa09t
         c2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K7kU/3v8PDN/H55Go4hCp9T1eZlcziQMopaRZ4NNkwU=;
        b=toqQvSfba+WO/9M9fsr7S4ls8dG9fmWWYnamtA4ZBIik/WbDCpUzkeugltVE5nUNNl
         yfpGKsYDAZ08uW4iwjWr6G/ZkbdhWUc0QfW3ttlB6Dg22llSz08JGuTyVBdoJE8kbS4V
         av0klfaoZvC04xt4EdER7ClN6pnAi2KIFmc/cJPJZReXN+BODxaEbbxCVpCV9vZDmvnp
         lrKA3yo8hcRZ5GrMuB06OPt+oVa0/MT2Z22+dIEgqlfHsiqpGKKBuolyWZrJOI0lEW+L
         1f8+n+SmVECSVPSuaaPcLVqpfMni2RuomMSh+JubLYsWA2VxEZksaVkBxQ7iZpHGgC6z
         eLCQ==
X-Gm-Message-State: AOAM532FNW/Fmi1KbOisnST5zYVlXxfLaoeO42rMwkvZR11E11Z+5rNt
        wdV0utq9Y2swFXJz0LRxq6tq+GFQr0i0u3vVyFaG1Bh00bA=
X-Google-Smtp-Source: ABdhPJzVDUYEgVL953CymDCtao64AGBKwMkhFbxte58mlQ8cj1PeDYYjNpaG1IoxOCfy5uzYKoDY9/jlXdW7txYVVTo=
X-Received: by 2002:a17:907:7fa9:: with SMTP id qk41mr22473277ejc.422.1637775496845;
 Wed, 24 Nov 2021 09:38:16 -0800 (PST)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Wed, 24 Nov 2021 09:38:05 -0800
Message-ID: <CAK3+h2zzrwv=S=CmgVo2e4Hubw8nvzbFhvpgyTiUh87O6APZrg@mail.gmail.com>
Subject: bpf mailing list archive
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I find it hard read bpf mailing list archive from
https://lore.kernel.org/bpf/, I don't have specific old email archive
subject to read, just want to read some random old bpf email for
learning, had to click older/next at the bottom of page, can't go back
in specific month/year range, is it possible to archive the bpf
mailing list in https://marc.info/, I find it useful :)

Regards,

Vincent
