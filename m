Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0703123CD
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBGLhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 06:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGLhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Feb 2021 06:37:04 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C47CC06174A
        for <bpf@vger.kernel.org>; Sun,  7 Feb 2021 03:36:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so14769362eds.12
        for <bpf@vger.kernel.org>; Sun, 07 Feb 2021 03:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DigkzbMGtQaTtIkYQrjN6ZN7A1ftuD6nATqfwI+W+q8=;
        b=h0Lp8ixJRDsOiChgrZQLRG6H3BNmC2mOpU4LMNHi/NpfA0Gx7eo8VPafoKIsb+aA4M
         q5osUJMMqAQxuEg6ab7HWDOlSGSgAVTYYt9nKwzuzxxkTx9AtZ3C2SAgnulIYSHkPZeI
         FbsoVnrHDa8NY0iFuEF0dlwmGmWIygH8MafCeKJPNWvl9qBqaUi3EHMxwKDR1rKDBFSV
         hdIy6VrxJFvUdpKDepH/PeCymQw2DNF/cmHfZk5ReJzQEK29BjkMsDOtwxGj+9fMiowp
         QcYwZwNY9UXfeoBlYHjR7IgyIaGg1z/wRNyoLtmjJPBxWPw2vgg73KtsMkL1qKcwSHyz
         z+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DigkzbMGtQaTtIkYQrjN6ZN7A1ftuD6nATqfwI+W+q8=;
        b=YKA+f3qMcNZ9qBIOg3+L08vvneuW0CfUtmQIMt+zelHfbUrrWDqPPvWjfHhifCgzyP
         rVeHCURiQB+oBUnfNxulzKwYYC/CyYoDGJtU6xzXlRaf8PVggoJTK/0EfeKUDPcgV01C
         IEzLqLJmsyNXsiOb5h4wHOv6diAcNE1KRcvuwTyVhf/f/qAs8ho0iVM5lPrzwp7MQCuQ
         J4wiGSrK7IqnXCEZpF6aC9XzWSE0dhLCbTFyELfPk9kLz4c56V9HnroXhQ8edIQDXQoh
         7VEMHm8U62J6JyPFqDRJXQ7gP4reyg7V0QyOG74I1DfBJM1nKmlnPTGIbJtBKXIxE18X
         gdCA==
X-Gm-Message-State: AOAM532KYnY5aI/f7KM8hldMCybT1RHQ9UG11hxZNBQ2QxafZizaFmi4
        ChEWsAQwXHNLwzXqrdeumyXoz2aG4nz5Mvrra/iindeGgfEfhQ==
X-Google-Smtp-Source: ABdhPJzRra6TCzhs+yG8nWXL4sXTz9/X2zrYXYXIJ3tnJkdXAyrYp62UyhF6abK/9kTW+LzxAhkPZpv9KE4rku0eXQ4=
X-Received: by 2002:a05:6402:c91:: with SMTP id cm17mr12647903edb.219.1612697781695;
 Sun, 07 Feb 2021 03:36:21 -0800 (PST)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Sun, 7 Feb 2021 13:35:45 +0200
Message-ID: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
Subject: libbpf: pinning multiple progs from the same section
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello there,

Last year, libbpf added support for attaching multiple handlers to the
same event by allowing defining multiple progs in the same elf
section. However, the pin path for a bpf program is obtained via the
__bpf_program__pin_name function, which uses an escaped version of the
elf section name as the pin_name. Thus, trying to pin multiple bpf
programs defined on the same section fails with "File exists" error,
since libbpf tries to pin more than one program on a single path.
Does adding the actual program name to the pin path makes sense?

Thanks.
