Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C81FC3E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 23:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfEOVgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 17:36:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35408 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOVgG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 17:36:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so438985pgs.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lj20BWGa/SSqkCUWhiNbUp+2jcIFFr5rWtfoPrCsSoQ=;
        b=pLODJpLNTPnjKZE6jiCeKVcXugMyLtlONq+lmg6tPOtTzJj46GJOU6Cf+nCpBKO8Gl
         QuPx22/EvuL7Mr6XG7dpT5RWwvPsfXc8SjNKuFgXNwGZ+VH8P/PM3RgZU3YOnnasoalh
         bPKxFuh4a8fB5IVVNP9Jhftas1hXtKt5gUvik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lj20BWGa/SSqkCUWhiNbUp+2jcIFFr5rWtfoPrCsSoQ=;
        b=Now5t+Jp6VtEZYSKLKiu1jXZyJlSSWGeny4lDKW9Gu3pvPnTvx16hRX+6/3CpPbEGi
         19NrSQjrnbWZ0YSNR25pFMZZnns8s2Og6aaaZgDTzqy2IBYbiUwVBDx4WqOEm3C0zcxQ
         Fky2e9Bfn/2MsW67kGtswytOqtKCURtzsRlGZ7bxviIc7xQQXzZ4R6QuzOq9ZIIiZJ4t
         lO7JGZvwVVXAmCBLOUSrpZArXSFNAJg+Ml6QlU/3aGZAE7ZZc69Uot5kAO6AvuM0f9Hd
         z+sVDR6seq/kLIlPfNHuxsSf2V/0ye90Ek3cuPhzaRi6ie7op1QYQ+HcTi+e+JF+Hqrw
         M9cA==
X-Gm-Message-State: APjAAAW2678Z6eV/qQZWrmkFXv7b1TrQZUMKzrGFGn8aG1JEV383PZKe
        SBS3xlyQurnnwG2128jUQS1iOg==
X-Google-Smtp-Source: APXvYqyBnOgRxt8JiSmMw1XdoLOfLDNy0r57NqMlPQGJOPaLskNz2bSXh1R4oaRAS8sq2GtwOuxxpQ==
X-Received: by 2002:a63:f410:: with SMTP id g16mr15243189pgi.428.1557956165115;
        Wed, 15 May 2019 14:36:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm3695279pgb.39.2019.05.15.14.36.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 14:36:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        gregkh@linuxfoundation.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: [PATCH v4 0/2] kheaders fixes for -rc
Date:   Wed, 15 May 2019 17:35:50 -0400
Message-Id: <20190515213552.203737-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Linus, Greg, Masahiro, Here are some simple fixes for the kheaders feature.
Please consider these patches for an rc release. They are based on Linus's
master branch. The only difference between the last series [1] and this one is
I squashed 1/3 and 3/3 and rebased.  Thanks!

[1] https://patchwork.kernel.org/cover/10939557/

Joel Fernandes (Google) (2):
kheaders: Move from proc to sysfs
kheaders: Do not regenerate archive if config is not changed

init/Kconfig                                | 17 +++++----
kernel/Makefile                             |  4 +--
kernel/{gen_ikh_data.sh => gen_kheaders.sh} | 17 ++++++---
kernel/kheaders.c                           | 40 +++++++++------------
4 files changed, 38 insertions(+), 40 deletions(-)
rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (82%)

--
2.21.0.1020.gf2820cf01a-goog

