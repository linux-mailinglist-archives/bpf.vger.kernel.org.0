Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2480F202530
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 18:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgFTQWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 12:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 12:22:20 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DEC06174E
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 09:22:20 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t85so2804411ili.5
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=ZFaDAYictEV71Pt7cuSV4Z+WzgOfXbyxah3i3EnbYlg=;
        b=F2rQ3+4Tlt9DT7xWpSUmfxZnw6xuIvjYu9ZPRSs1X1SBYPeh6Ca5qygTuu6nXX1vTy
         inYd8OEZCSxnZs/aluqqvov0o7X6oONiWrOA1YYPcM4MNaSISkXa22ZSlHIMjAIEXpyc
         FwP/6Q55dX9qXKjsoE/4yXyEmv1lXriN0GgY73vWbeW2lOWgMl7qMn0YV7LyqCy98t2o
         olAyW+oX2NQasn194mi9Y/YK2uREOHaZU0Wl5RxuJ7/OmgOYMcQsVwDXk5ujXBv0ZRDE
         l9GbZ1RTi4t4DRS4KSJlSOGTuFPp/vsRjqDY0Y1HAl5QOqqufiWkEqc+3hQIRowmg+kr
         2cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ZFaDAYictEV71Pt7cuSV4Z+WzgOfXbyxah3i3EnbYlg=;
        b=LFRWlwhP5oNxCvPOS/+BAGprQP9O7Gp+8AytURhDHlKtPtn6vnI5d+VDexX9OxZs1l
         zWRDvE0Od7IM1SqKeDLXwfBuxanJMbx/+cMqyl2Y11aCXoO9pPIEU/4WK099UbKKZq14
         VkiuVXrtDKv6Eed0TEnFEcYGkhJKLengUUEzGflqrRRFkzipn5WZzODapTEOQi5cZObj
         5+YCKvSjTdLP5Op9TIky9fhKu0jyZIifFlIUn/ziIFtW2X+dFLwEAaHF24Qmxa9ykhWU
         Fi2zeA4kvOYwUZIB1ZcsQf/Gjzzr+fg/+4dupWHdSdwIXAahq4NBnV4Yb70Yw9XUQ+g0
         yNBA==
X-Gm-Message-State: AOAM531unQTXB2Jk0jZIxKuZYwpG8CnYSH4ERf2Cx/3d8VzfI4oTZO2q
        2a1DhhB7CLCiSyYQnrXeobocX7Nffcg=
X-Google-Smtp-Source: ABdhPJz30ARIWlcA6YyOoX7JBJDWIlfEKhBsAmLWTUf9tw6xNgSyket3sLzr366BGz87ur2Ns1QX4A==
X-Received: by 2002:a05:6e02:e51:: with SMTP id l17mr9444831ilk.39.1592670139575;
        Sat, 20 Jun 2020 09:22:19 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id l9sm4891720ili.86.2020.06.20.09.22.18
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:22:18 -0700 (PDT)
Date:   Sat, 20 Jun 2020 09:22:16 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     bpf@vger.kernel.org
Subject: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

New to bpf here.

I'm trying to read values out of of mm_struct.  I have code like this;

unsigned long i[10] = {};
struct task_struct *t;
struct mm_rss_stat *rss;

t = (struct task_struct *)bpf_get_current_task();
BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
BPF_CORE_READ_INTO(i, rss, count);

However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.

Any advice or documentation I could sift through would be greatly appreciated.  Thanks.


Matt Pallissard
