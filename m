Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A84660B8
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2019 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfGKUfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jul 2019 16:35:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbfGKUfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jul 2019 16:35:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so3483079pgi.6
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzejW6SFWbN3L3KZoDC9nTb3ZhvphpGEogU+EB/2Irc=;
        b=mzbmrf+fddukWbjz84vx/egC2BsjJhpBLZ3HLwKLmN2XjiY75b+nrcqUXDNoiKaaT2
         Ryexulp7bneomYExeY26g/7C+ofh+dR/vkdoAAma0IYdyRygk76D0sZ2yh/MNUiQ8Zj/
         knJCngR4UUUmpzF5HfQCyIRsqb+cQHkr/piOJkUZUGX2FY/Mfdw1MPv9o+pmaghnFspo
         lVrvFRIz2YQBPgESW8ZdateqKuZZFkdilNdrfUxRcrNezjIV/Hps9Ven+6i9tIv3lGhf
         U0hynwpt/Xv/dSTCIvYZPZtPZ/RTqC4h2ct+6o8Zq51J0uFe2BmXgtwHePWrGjxhVzDw
         iurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzejW6SFWbN3L3KZoDC9nTb3ZhvphpGEogU+EB/2Irc=;
        b=qPj/w69Mxh/ul8fmrOItlaIgBMUefqprsa2MdhereIHIQjOX4lfjOA6RcesEgxI5d+
         A6DNbdoNwbdc0DHgglf5BRW+uVn9kzmjjYX6NZPR7pbK2gIAa+txfzMtuNxlC34G1U8K
         D4mdeZPccG9CTGJAF9cA5PdqvFXbaWq9xlQCSldoBIVJZ/iLV5aZPAch3MRRuJeaQllY
         lKEOgdTiHPZmmBGIUjYmRP3gzKV/9BH8ldhZuOoXlZcCwx1GxNE9w55EsVwKCngu16H5
         yLn30HTjVGLKvxKdVVvdworPUvsOZRE8xDWwXYPPsSXsJgAZRAmM1CdjLS9mJDa691iY
         shNw==
X-Gm-Message-State: APjAAAUnloxSv7oi7JTH9SMAYY74G+Wdx+TQzRoCy+h204pO1hUDVBtU
        R2xBwgDBlYYPjqq/LD3JgPw=
X-Google-Smtp-Source: APXvYqw8usqf0XAg/bT0fCmnMRScD2DXRrjDSMGe5TkYGY23cENwnrdQfhC2M82dOQinH/FqgiPFIQ==
X-Received: by 2002:a63:3387:: with SMTP id z129mr6321977pgz.177.1562877310350;
        Thu, 11 Jul 2019 13:35:10 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id h12sm9912061pje.12.2019.07.11.13.35.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 13:35:09 -0700 (PDT)
Date:   Thu, 11 Jul 2019 13:35:08 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ys114321@gmail.com,
        daniel@iogearbox.net, davem@davemloft.net, ast@kernel.org
Subject: Re: [PATCH v4 bpf-next 0/4] selftests/bpf: fix compiling
 loop{1,2,3}.c on s390
Message-ID: <20190711203508.GC16709@mini-arch>
References: <20190711142930.68809-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711142930.68809-1-iii@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/11, Ilya Leoshkevich wrote:
> Use PT_REGS_RC(ctx) instead of ctx->rax, which is not present on s390.
> 
> This patch series consists of three preparatory commits, which make it
> possible to use PT_REGS_RC in BPF selftests, followed by the actual fix.
> 
> > > Will this also work for 32-bit x86?
> > Thanks, this is a good catch: this builds, but makes 64-bit accesses, as
> > if it used the 64-bit variant of pt_regs. I will fix this.
> I found four problems in this area:
> 
> 1. Selftest tracing progs are built with -target bpf, leading to struct
>    pt_regs and friends being interpreted incorrectly.
> 2. When the Makefile is adjusted to build them without -target bpf, it
>    still lacks -m32/-m64, leading to a similar issue.
> 3. There is no __i386__ define, leading to incorrect userspace struct
>    pt_regs variant being chosen for x86.
> 4. Finally, there is an issue in my patch: when 1-3 are fixed, it fails
>    to build, since i386 defines yet another set of field names.
> 
> I will send fixes for problems 1-3 separately, I believe for this patch
> series to be correct, it's enough to fix #4 (which I did by adding
> another #ifdef).
> 
> I've also changed ARCH to SRCARCH in patch #1, since while ARCH can be
> e.g. "i386", SRCARCH always corresponds to directory names under arch/.
> 
> v1->v2: Split into multiple patches.
> v2->v3: Added arm64 support.
> v3->v4: Added i386 support, use SRCARCH instead of ARCH.
Still looks good to me, thanks!

Reviewed-by: Stanislav Fomichev <sdf@google.com>

Again, should probably go via bpf to fix the existing tests, not bpf-next
(but I see bpf tree is not synced with net tree yet).

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> 
