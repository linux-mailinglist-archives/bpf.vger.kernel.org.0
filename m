Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B824A2FE8F0
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 12:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbhAULgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 06:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbhAULgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 06:36:05 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A46C0613CF
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:24 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id e15so227395wrm.13
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RLqFM69+cwerT+J14ehkQ1TCgXTjDoYcdw/+HxoiLlQ=;
        b=OVvdRA60rUXQhX6CJUQlmaolg525BpaF89HHflbqA18S9+3NvcKcRzCN7IOOblwSjw
         fca+MdYSx9unqVHBx2pYooVJLXbQVDH0XVWonlW7ntZwMXS3XE1e4Ziirx0eIoXAIWiu
         GPrOwsCFzxvBd1xZUvjme8Pgoxcgqst5x/Jf4k5Kirjq1rP2HEYJ0XK5HdaAMaOAmWwF
         NbmK9IN7kRa3WgTyjeo2lY9kd20o1F98jPxeVCpalApdBhM2NxWozbF4JW2tZu4RHREv
         ATDSZy1+CKYa1iwfZMvwHffNwH0HfY0BW6tfo3skqwvrJoSRCKrLvWLqi2iVzHcYzh4W
         Ww1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RLqFM69+cwerT+J14ehkQ1TCgXTjDoYcdw/+HxoiLlQ=;
        b=N/afAztNw/Ag77EcDqfujesaS3p//xMFUEaxChBU3poTx3tHRj/5YDN3Wyy3Lxpom3
         FNnGrqu5IcBw2V7ABtAfaB+c7/iaDoetMny0w7o39N+Iq1GRTtVEzm4p7zqwvXVu3P0H
         9eZmZOCQkoZFJrldEMXeVxz+5O6HDunnw5zVI8yNdfiKUehqtZoe6+BmmpPaAaURHy2n
         945erfQ9E2SQgwsnLsRk9XCQzf/NHFEkGqPvvy3pLDS/7eK+a9yAp/UuWWPREPYOjcsv
         qS/YAEaY6LyQzA2GvOa/tNAKpwahXgZEwKjJ8Yx9Mj/0Z77zuegJHpNgKSlx87bq7VnE
         IXUg==
X-Gm-Message-State: AOAM533+ohlLQrOqPB3K0HLbD02mwxOJEscATFssStbFIz/PGwmDWs3F
        /Z3ZLhB2/M5V1dHfBYSHKutYQGYPecvKMA==
X-Google-Smtp-Source: ABdhPJxcb2YEyONdJcJDYYnei7dn9V9QxeVjhfQMLAGyFO0bJMsrzSLFcKA54bWAH6eJul5MY0FwzDRVTk+TRQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:600c:2281:: with SMTP id
 1mr6419931wmf.150.1611228923361; Thu, 21 Jan 2021 03:35:23 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:17 +0000
In-Reply-To: <20210118160139.1971039-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-1-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 0/3] Small fixes and improvements
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.

1 is a bug fix affecting restrict qualifiers.
2 avoids leaving debris if objcopy fails.
3 aligns the BTF section to 16 bytes to avoid misaligned access.

Note: I think 3 should be in abandoned in favour of using libelf
directly. I'll give this a go. This would also obsolete 2 in its
current form.

Regards.

Giuliano Procida (3):
  btf_encoder: Fix handling of restrict qualifier
  btf_encoder: Improve error-handling around objcopy
  btf_encoder: Set .BTF section alignment to 16

 libbtf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.30.0.296.g2bfb1c46d8-goog

