Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3B3F33E5
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhHTSfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHTSfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 14:35:51 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D77C06175F
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 11:35:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 22so11830984qkg.2
        for <bpf@vger.kernel.org>; Fri, 20 Aug 2021 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:to:cc:subject;
        bh=20/a0sZ2dzFKeddKBSkNEVtv2AMo9NoJrHJmvABR31k=;
        b=iraa4Yg2ZIyDuLWjWxoz7XhaITVgAYkL2+UmLSFrqzMB3Uvs29V23Zg5ZWoo3nSrSZ
         b0dXIrjTqoCGqlt1bugRacT5AbM7T5760fHd5UgMw48rJMdz4pQCKgkQqu+1q6icd7Lh
         tR4z5xVyYZXDdAyNdKWuDuKWkAVefKGJAU+UbRIwopG6QmTsWlPBx9e+xAAOzGooNbGA
         /5NPhzg0yAMk99xz4CasbFUmtvV3ciy4mALUH8pW1BZ0fEBCJlOUuEc8VXFVTaPaSSfd
         lX0gEIIFctA+XwIkf/dWjE4RhQP77SJUbdLGVanMyBnf0sf3Vbd62+dQ9ux2O4jgxyRK
         V1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject;
        bh=20/a0sZ2dzFKeddKBSkNEVtv2AMo9NoJrHJmvABR31k=;
        b=d5+52nxmSjFC/7ICHsAFF5sLhydqfGyLv5TAIFcNPa+G8JpvwM6i4RKgiq+lfMlwnP
         rdsLANItZAGsDrRWS01z4N7RmrE7sIrqFfFTLXhRSAVAAexBHJwj5YEWuTYc6jOrU+/Q
         dNp5b+XtFDHNzO2vGwbomS5OkUDt5P1N30UY5SOFEOPjDyVm1IENv56Pjo7Fj2bn1xmI
         57yJQB7IOzXbfyeyffDNTpiaKaor+LYqT9yGHj+S3mqTparA/4GZIoGlGisCSFNdaBWN
         ikN+Sjkme+oJNwI6AN/glZ3iE80lZN3+dgoXf1kemHjhGC5bTLJZt4JoKXdRvjAzpXP9
         W4uA==
X-Gm-Message-State: AOAM5308xAk5vbdvzIw27/CEUXYW47In91nQ1LEnjC2DzETbBwmhTIJY
        j0oeJs7hKbufEpTFhcuBkiw3S1QruH6IgQ==
X-Google-Smtp-Source: ABdhPJyu6VME/MSR6isTYWyYplihN92JlMd+BYrZuko4mFZdVnneppsOXB+uYbKpE5mJc8NKjPKd6A==
X-Received: by 2002:a37:9481:: with SMTP id w123mr10382554qkd.75.1629484511800;
        Fri, 20 Aug 2021 11:35:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p187sm3584045qkd.101.2021.08.20.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:35:11 -0700 (PDT)
Message-ID: <611ff5df.1c69fb81.43234.a478@mx.google.com>
Date:   Fri, 20 Aug 2021 14:35:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2021: Cancellation announcement
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Due to the continal assessments and growing concerns around the spiking COVID-19
infections worldwide we have made the decision to cancel the Linux Storage,
Filesystem, Memory Management, and BPF summit this year.

We are investigating dates for 2022 with the hopes that we can finally hold a
safe and productive conference.  When we have finalized those plans and are
ready to begin planning again we will send out a new call for participation.
The current board will stay in place until we can successfully host the next
conference.

We thank you for your patience and understanding while we continue to work
through this very unpredictable situation.

The linux plumbers conference is being held virtually, and there are several
micro conferences that cover the various topics that we cover at LSF.  If you
have the desire to still talk with your fellow colleagues I encourage you to
look into participating in linux plumbers and possibly submitting talks for the
appropriate micro conference.

Thank you again for your support.  Our sincere sympathies are with all those
who continue to be affected by this pandemic and wish for good health and safety
for all.

Thank you on behalf of the program committe:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)
