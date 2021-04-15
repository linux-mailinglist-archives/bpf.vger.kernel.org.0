Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41FA35FFFA
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 04:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDOC1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 22:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOC1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 22:27:04 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9E2C061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 19:26:42 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id b20so11084724vsr.11
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 19:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RQ+TPpf4nTuLRO9gf/mUuM2j9FZW76OLQttR/M0AmyI=;
        b=V0r0Pnw/sLxw4/vxagh6YCWU4at15OYsUktxCDdqsmDCAzDpOxES5TtOQlc/53tkli
         RYt+nQvdusfR/5nr+ofmPcupYkNc1RExLsEpZAtuf0gHmulwC3DpEFAuwnWn2ph7VjRL
         dT/EDBmK7zXKqD6iDQRtCGzkc+8TzXWBEDm2sUQI6Y/c19SxeCGJzXYVw9HB9AVGb0JN
         zLUVww1ymD+YA5chFbaZ39kUZJmDlU3HYlG28Wl1iOa0j3hpG9Gam+25p0BIw06x32hl
         p285InOQFbve7UQZ7eAgf2AoyrQnlya/aHeB6khyxrYP1kr0r/YVivrfyiZTBCMsZf8J
         xBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RQ+TPpf4nTuLRO9gf/mUuM2j9FZW76OLQttR/M0AmyI=;
        b=oNp/PnLw0JAADcysRiMtlLnrCdc5SoC2ByOsIGbf6ifioLz+VZ3YN6sDz5tNNAtU52
         XORJOXqFDdw18FUwiy1WMPHEYZ+YDeqwobeMKOycI4CMHD1zVaIc9xIraqdnbZaCKkH6
         sZwuBbFa/n5Z2u+JdZ0cXnRwM2AizZTAkCc/whCC3IjTOj3luFuzPS61xME8FAV33HMZ
         DGcN4seN7SAulvrr7tvnoiviaMJLMfO96FJRlQsAMTMrX4vco9rY4oJgZHw6J1cL/m8o
         TbQAAUDUFVwMs7FIAuFhhEzgNnEvHKIazXvsyMDoKO5esS2WFLtkQLgigWs+26qxakhY
         Dh+w==
X-Gm-Message-State: AOAM532WLv4TPJLhp+fFqX18hgyKC+XSx6nGC/0TgYQq7XZyota7iOZM
        UMFzndUv/xaD1X2am+hEpEYYLIAS/a0c+nY1ZBnZAOrFak+YVA==
X-Google-Smtp-Source: ABdhPJzUjEtSH6sFjk/rLU1iWbwX/y6iyz8FxSIOXAJXPjIU2Mf+J/GjyFPAdQpSD3T28enCwf+m6hScqNuzrA9h5Ew=
X-Received: by 2002:a05:6102:30b0:: with SMTP id y16mr792271vsd.9.1618453601355;
 Wed, 14 Apr 2021 19:26:41 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 14 Apr 2021 22:26:30 -0400
Message-ID: <CAO658oVyB2b+Y6K3--sAhTcXfmPpmPjLhA0z7bbjyjhzDV8kcA@mail.gmail.com>
Subject: Access to rodata when using libbpf directly
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As I understand it, accessing and setting read only global variables
from a userspace control program through libbpf can only happen when
importing a BPF skeleton. Things like `bpf_object__find_map_by_name()`
are exposed but the name of this map is internal and
`internal_map_name()` is as well. Traversing through the maps array
via bpf_object directly doesn't seem possible either.

Why is this feature only available through generating a skeleton?
Should there be differences in supported functionality between using a
skeleton and using libbpf directly?
