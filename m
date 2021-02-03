Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0030E62A
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 23:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhBCWj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 17:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhBCWj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 17:39:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F7C061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 14:39:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so1186428wrx.4
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2ZXCMlNVDtB/MUW8yHTVMc1E3/PprXus9Gx7blpTUg=;
        b=RMP9eOZmm8ZMwJY0kPy9gzrfrIRWK5BSgDPmEVFEqNok5pv5tMpGJWrLxeQL40qV81
         ak6q+kBj6O/+AabUG8oHWAUNVXANo8VNjtaT6xujcyOm96mbXMh1UWRBMC5Th0dinxQa
         iRuN1wwUfzfz5LXYN9UsBZnbz2aPT5BnP9PewPd3IgAlTIYXx5egcRhEPqAlRikqoYmS
         BZOgfkvlAop2mHWu6DnlC9933RTXJ086KXsujG1VtaGp0ji8bA5faF0rL1fwmtymCeSi
         fVtzKWL9c9KSAGwN17y684hx8THzxVYaZoNxNvngMf4WfCFGG/QJ4OJukgJ+YVOWnJoY
         VrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2ZXCMlNVDtB/MUW8yHTVMc1E3/PprXus9Gx7blpTUg=;
        b=ss5ikViNv2hbRajNGzFbSiluI7R3P0jmOL5cZTxs1QRhoZI9CTs8J/En8/63jWp92A
         a2luIOUOPwsUNEyXlkEXRmHYekBkLsiFAxGmv4GKCsi0TbtnnHWGWK+nSFzW7qF/HAy7
         Y5zKxK0yjuGKk8o65S8Jkn26NbWMKOvzCTLMTYHjj5ZZjzlveU820TrpTTV1eFVML6xK
         v057cu8/O8DJxdSacOJPyNMrJhOvXqBqIOxBcWhBcJfvwcYT/gcUzWRbQAeLH6C9Amb0
         1saFpNNwrT4mJefTSJogGv7ttQtACSaIXnuA5jhQfVRcdx8wuU1pab5adVhxoiCJm0vd
         6IqQ==
X-Gm-Message-State: AOAM530ER5vU4sQRyHwN3i89Bo+1+JerATMCUQGpFVmdftFlaemegXwl
        vRWVqDLH1AmfjT6lV0gRtxAs3ifY/3NjOn69MxJmTw1tV8a/eZ+v
X-Google-Smtp-Source: ABdhPJy/zu+SIuCO36g8AKfKqN15KQfh0tkijBDbwQuOXUajM1jQ1zPjo/ZCx+ciBptTHn6U+sCjoy3iC0oE+SmsEYg=
X-Received: by 2002:adf:83a6:: with SMTP id 35mr5851976wre.274.1612391956721;
 Wed, 03 Feb 2021 14:39:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
In-Reply-To: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 15:39:00 -0700
Message-ID: <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Chris Murphy <lists@colorremedies.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 1:26 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> qemu-kvm VM starts with kernel 5.10.10 but fails with 5.11.0-rc5.
>
> Libvirt folks think this is a kernel bug, and have attached a
> reproducer to the downstream bug report.
>
> "I've managed to reproduce and found that virBPFLoadProg() logs the
> following message:
>
> in-kernel BTF is malformed\nprocessed 0 insns (limit 1000000)
> max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n
> "
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1920857#c4

Looks like the bug was introduced in 5.11-rc5, the problem doesn't
happen in rc4. As I mention in the downstream bug, I'm unable to
compile a working kernel for bisect between rc4 and rc5 to find out
the exact commit that introduced the problem, due to many messages
like this:

Feb 03 15:05:47 kernel: failed to validate module [coretemp] BTF: -22
Feb 03 15:05:47 kernel: failed to validate module [intel_powerclamp] BTF: -22
Feb 03 15:05:47 kernel: failed to validate module [irqbypass] BTF: -22
Feb 03 15:05:47 kernel: failed to validate module [intel_powerclamp] BTF: -22
Feb 03 15:05:47 kernel: failed to validate module
[x86_pkg_temp_thermal] BTF: -22


-- 
Chris Murphy
