Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0D2A8C7A
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 03:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKFCOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 21:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgKFCOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 21:14:22 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC164C0613CF;
        Thu,  5 Nov 2020 18:14:22 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e21so2736289pgr.11;
        Thu, 05 Nov 2020 18:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zA7qEoSUaqfTegr+OwR1i9UncfOv0l2weHhHNCQqJPU=;
        b=h5P4tt2GZbmmi+hPInl9zPqprfmM8XHHWghKUtmj3IDnPHf6KcCzv8B3mQY12RNKzj
         d3IXCeqcC25QCj+p4UEnl0bsLedW0Es23PkdlfxLKHUrL+uu1tWvJuj4zMdybuA/3Juo
         3/AApiusZFkwikfVWRjCU5a0JQZUIsydfdWUy0KxvuqtUZJEScC4spKieZojifyDqutv
         BoEVbN7qRlvUc6BqjUQ2KDLBLKLkIPBNLI5sMKe6emY0yz2yVoyTonJcLVIoW9soCLaA
         Sx/1vXAFo46jsFfvkgA9HjGgejcPQmyJubDOO0w6YARAdWsOJo6vS3J5KDFxK3KM2JnC
         0emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zA7qEoSUaqfTegr+OwR1i9UncfOv0l2weHhHNCQqJPU=;
        b=LpYGRzi0hSb+C6Cl8E2cdLQQCG29uuQHA+m88K7R8Q69JFiQi6BLShwCaisY9O1K5V
         B7nSt3GrrCv5sNeFQdNQwTInB6kGcTPEi2pCJ76wbdgarLBp5GsE22a1OU8bmJpOtFTI
         VQKt3B6kRh9nhLLVqmW2zdcFZkXGgsxBS/1XxEe3JBsJKql20QRiEkwtMs/RkTMNWjkM
         rAqN+uVpc3uywzRD1ETEQBxysl7T0kiXFIkbEPcvfM5lWCvQRiYDR0Rt7SuepVw5X7yb
         PZmLMH4EFOiKqzxmggilPx6itS1ZsNi5ZA8ecTmLq5F9LPCj6keo0wwO1F7fqH96+Q/k
         SWrg==
X-Gm-Message-State: AOAM533VHjvPzogA8c/RXlIzLwo7wRN0l+p5y4/wt3WK7GpLJZxPpa5T
        9kK7pnkwn3trMLswKLStDQg=
X-Google-Smtp-Source: ABdhPJx4tvrrPK3BMGi6Q5Is4DgVF/FgnhBISqy0Nx8P3gAmD1HYtqzINepIesVVmljQqgSZJErnwQ==
X-Received: by 2002:aa7:9d81:0:b029:18b:4489:1e59 with SMTP id f1-20020aa79d810000b029018b44891e59mr5291458pfq.62.1604628862164;
        Thu, 05 Nov 2020 18:14:22 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:b55b])
        by smtp.gmail.com with ESMTPSA id c67sm1557882pfa.91.2020.11.05.18.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:14:20 -0800 (PST)
Date:   Thu, 5 Nov 2020 18:14:18 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v5 8/9] bpf: Add tests for task_local_storage
Message-ID: <20201106021418.w34sar72sbddzwqo@ast-mbp>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
 <20201105225827.2619773-9-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105225827.2619773-9-kpsingh@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 10:58:26PM +0000, KP Singh wrote:
> +
> +	ret = copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size, 0);

centos7 glibc doesn't have it.

/prog_tests/test_local_storage.c:59:8: warning: implicit declaration of function ‘copy_file_range’; did you mean ‘sync_file_range’? [-Wimplicit-function-declaration]
   59 |  ret = copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size, 0);
      |        ^~~~~~~~~~~~~~~
      |        sync_file_range
  BINARY   test_progs
  BINARY   test_progs-no_alu32
ld: test_local_storage.test.o: in function `copy_rm':
test_local_storage.c:59: undefined reference to `copy_file_range'

Could you use something else or wrap it similar to pidfd_open ?
