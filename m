Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B74C8B2B
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiCAL6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 06:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiCAL6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 06:58:07 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1C21BA
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 03:57:25 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id ay5so10434061plb.1
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 03:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iCNKzMB3zJY1Cup+wCHOA/6XbdbbVPqzoSV520MdTO8=;
        b=Ff4ktQ5KKJx0s8HRLGCt+7cwr4HZd5dVVI6ZlaD8l2kVHCHHlvldF3E1lB7CE3UGap
         phvojgHmyqstT7jawaqzDljvLk0NWdX61QfHG1U/mzvDzRLty8l5hgR9C+XLHrjf/QvQ
         W5gFBIjIjpHm/KMBdpI9aJXa1/H5vCmx97V72UleBgH5x9YKBZ75YcuXwBUzVMDE84lm
         /Z2u9aObPkXdetor6TeUgRhoZQbY2xLKEAtkjLyahJYllbqt77pxH31+FyU+dhzabNr2
         9Oo3mBfKL535y12p7vZ5uQQB1sjfhAweyj2T+vh49soqhmlStabH67TGez6yTDfcSglV
         hWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iCNKzMB3zJY1Cup+wCHOA/6XbdbbVPqzoSV520MdTO8=;
        b=MJHvssLJVEI/R283CALoPMs9088BE0XNzTMlKiimi4buh4yF+ZmEPc0fzPk6dCtnJ3
         K9cRyKgflNjbFxW1SZcp7ISI46Oi+uNYY9o0uA91Yr6GynsiMOXLxIm+vtEa+Y+pAH1L
         FdOsDqLZjIU7ageG4RUaUPAgQ1DZpfl7tAPgZOzK5xl4pVc05BYrCniGy7SzqXrQWsLY
         62g0gI6oUA3A8B0flkBpYITwetk6d7p3jH+bQVgB/u7p+Gn13RKKfbs1/Ak6AC3rpHrF
         5B/1+oDwMJ8zF2IS57vxAsxtfqAjIm3uRsGAigo6ahXurPnmtnLdXz7o2DeFdOibvl90
         /p6A==
X-Gm-Message-State: AOAM5337Zqky/r8pqS6czt0jFBzZ64z8ioA/0OI3KxlU+QPF53aE7B/0
        vUWRFhC/WgRkJkNBykSiQwI=
X-Google-Smtp-Source: ABdhPJz4aYN7GN3SvS8gGUwUqQMzUEWprZzc/s97hxL6yA/ucBXFi9OJLcTohT81Ul8Eyf1pAhBqQg==
X-Received: by 2002:a17:90a:bb8d:b0:1bc:72a9:a07d with SMTP id v13-20020a17090abb8d00b001bc72a9a07dmr21284515pjr.9.1646135845014;
        Tue, 01 Mar 2022 03:57:25 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id e30-20020a056a0000de00b004ef299a4f89sm17380511pfj.180.2022.03.01.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 03:57:24 -0800 (PST)
Date:   Tue, 1 Mar 2022 17:27:22 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc
 register offset checks
Message-ID: <20220301115722.jjklznmjsbnkdsf2@apollo.legion>
References: <20220301065745.1634848-7-memxor@gmail.com>
 <202203011937.wMLpkfU3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203011937.wMLpkfU3-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 01, 2022 at 05:10:31PM IST, kernel test robot wrote:
> Hi Kumar,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)

The same warning is emitted on clang for all existing definitions, so I can
respin with a fix for the warning like we do for GCC, otherwise it can also
be a follow up patch.

> [...]

--
Kartikeya
