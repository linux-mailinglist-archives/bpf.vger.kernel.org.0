Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CCA3115DB
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBEWno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhBENnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 08:43:18 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DAEC0613D6
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 05:42:37 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l3so4956652qvz.12
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IGpyT50ZsOIciQFmCAO819uoUHUYFH7dURB+H5TNyyo=;
        b=pGzIiS8uenAMefZwcV8gF0t6bCdBalkQ81lc00JAvU2AulD5fdy5sUr8R0VU/UZVmw
         IFXl2T/NFDgq10ByBMKuOgTnKaEXXRQdVbZi0LNFYQEkrTOFfN0yTM7X2pWvofXYIAFT
         emDSQt9ruT2GairKINejmb4r5En1+QGTry5mvlLXRnmBt3MHE686H2iZNPkDjXo3+oYV
         tQmaeeVlnk8LZjWqp7m5UqRH6IOGkXCrmJ3WD9TeX6Jsti/c8nmEjcqKMQ57m6Uxplxg
         CrItrPnCx0npjJUDSzj8Jt/TkOH84SNpZlJ4NRXDqjMLtaETKh60RzboyMiRteZvAbHx
         8GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IGpyT50ZsOIciQFmCAO819uoUHUYFH7dURB+H5TNyyo=;
        b=b4iSKQKLvs9MAWgjlABly10YF8J/gZRhBhpMa2wNIXMF+HdDmzp3bg5FJuDbVJi5lM
         3NX/bZ/6FdpnNEepTtCsURDqrAfICs4dMYJax3eEOAPsh7R06k8pg/UyMvH9q8PPUMU7
         klelgcpF9X6DiflEFt4IUpVvH3hziPQMxSdsQeJ4Po0iJtMYtxyEDr64YVUQouz481PY
         KdrJdH7i+0dveLuso1uBoe3gb0m892fspV2bmLyl6/L2kqVxfit37GM9O8i9Tu4hMWVT
         Dj5bgvoO6tDdhTEPXNtZ9HjTEe2oLpNetWjbliD6To5aEY/gmlGOYAP/Son6jBHsYg0b
         IyZg==
X-Gm-Message-State: AOAM530reIQGUoDHV2x70FRuOsCHZTYU0DaRMy9zNdUzzOZi4zf1+N4c
        11aupBY3dbOg3QvyKUY88zJXX9NUdRXe1Q==
X-Google-Smtp-Source: ABdhPJzwa3on+DeHXWNowl5sLCJ519ChsSKMFvY0uqYRHnRWpKpD+sjjqxEOI6xvfwCcu7IrSpamvDlytHmgBw==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:ad4:58b2:: with SMTP id
 ea18mr4480346qvb.52.1612532556716; Fri, 05 Feb 2021 05:42:36 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:16 +0000
In-Reply-To: <20210201172530.1141087-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-1-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 0/5] ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These v3 patches address comments by Andrii and Arnaldo.

1. This uses a variadic macro and relies on a GNU extension. It can
probably be reworked to not use this, with some effort.

2. I was following the original code that had aliases structs and
pointers for the same data. I adjusted my code not to do this (later
commits) and changed the existing occurrences in the same function
(this commit). The net effect is clearer lifetime and ownership.

3. In a similar vein, the variable scn really only needed to be a
loop-local iterator.

4. This removes the dependency on llvm-objcopy.

5. And we set the alignment on the seciton.

I'm not posting the later patches that perform explicit ELF section
layout and which (attempt) to also do things with ELF segments.

Giuliano Procida (5):
  btf_encoder: Funnel ELF error reporting through a macro
  btf_encoder: Do not use both structs and pointers for the same data
  btf_encoder: Traverse sections using a for-loop
  btf_encoder: Add .BTF section using libelf
  btf_encoder: Align .BTF section to 8 bytes

 libbtf.c | 183 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 114 insertions(+), 69 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

