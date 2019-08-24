Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D799B9B1
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2019 02:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfHXAaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Aug 2019 20:30:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38702 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfHXAaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Aug 2019 20:30:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so6029151plp.5
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2019 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xnR71yxvWSFn7GNIN4j2Fr3rKuwX+n1QmLSLVRDzZPA=;
        b=W2AM6gexTKN/VXcMZcNlCQUd1t7QNxA2cYHEuT6iNPI+LLeisFbLGSp7EFWmfR/GqJ
         ukVzvf47sFPlyUlhrgBgefa3c7ywbe85INX7ypVuklNfnx6nvpvLMTazX+f0PYBsK3j8
         2eFIoiuvEZOQxF2Jqk0NRW4rLxK3k3vp7yuu3KLd805bbiw/GDeFzDlmTkMRh0b+e8u/
         6BdSDVqdKECnS95a+YReAWFtZyA/LxvK8E48vaGRDb5CzKWAI/aSoy+v3zqvrFPazhs2
         BfyBlcWZkL2HrkKyQ5wWUtZpK/NGNqqCX1lpcQrzvqJSlXIl3aUFcEwmhjE1//XwP4sl
         fDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xnR71yxvWSFn7GNIN4j2Fr3rKuwX+n1QmLSLVRDzZPA=;
        b=Sg+xtigbawo087k0kDOMb5gCug6VlFeTWPGur85F6R9/hg9GLW7uu7vOgUgl8yvRXw
         Ol+VUK5LaquDrYJ1tGxKXmWUkxSDg3y5cKso8n6uDIa918ACtNXaAaM1X3qhhVfqkVmX
         pBQp9OTYhHAO/rZyShjSOwdkebi73Fr1Apt0V46Ui3Nxvhk/zgoHPxLWNd88wuA3I5Lp
         EysG/2AMwDk7Ea6nW0MYgwu2Q7tLfKG4UmeKqPqvZiL3XgKbiN/HX9yyjKfYMC5UmIIn
         ioiUadEud3oa2vH/aYEtjHsVDDlPTUJb/mr7KUBr00Ie1ABo0ajyfxXzzdBo1SliTVj1
         oiqQ==
X-Gm-Message-State: APjAAAVOJSDMrFzymxUAeQTHC7YXw3diM15f1zvDgMxYVkHkmhb4QLHV
        zvZfSb/D+7dysi4mS2hjRBAXbg==
X-Google-Smtp-Source: APXvYqypnIHRw+gX7a2zAkaV+URyBUoTsPo6A6KcuRTTuMEOhltXd4pwHW+VP0k4vY8gZmJbUDCW8A==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr7207697plb.299.1566606654666;
        Fri, 23 Aug 2019 17:30:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h9sm2890450pgh.51.2019.08.23.17.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 17:30:54 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:30:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
In-Reply-To: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 22 Aug 2019, David Abdurachmanov wrote:

> There is one failing kernel selftest: global.user_notification_signal

Is this the only failing test?  Or are the rest of the selftests skipped 
when this test fails, and no further tests are run, as seems to be shown 
here:

  https://lore.kernel.org/linux-riscv/CADnnUqcmDMRe1f+3jG8SPR6jRrnBsY8VVD70VbKEm0NqYeoicA@mail.gmail.com/

For example, looking at the source, I'd naively expect to see the 
user_notification_closed_listener test result -- which follows right 
after the failing test in the selftest source.  But there aren't any 
results?

Also - could you follow up with the author of this failing test to see if 
we can get some more clarity about what might be going wrong here?  It 
appears that the failing test was added in commit 6a21cc50f0c7f ("seccomp: 
add a return code to trap to userspace") by Tycho Andersen 
<tycho@tycho.ws>.


- Paul
