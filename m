Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF328C195
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgJLTpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgJLTpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 15:45:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96826C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 12:45:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q9so18805678iow.6
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Tss/LNwFImxrLQsqwbSE4FC5/jSi91pDw3mZadacVew=;
        b=FJLhIUEPCYHz17T9JYvwmrXiz0+XAD+3MKr7HaY6DElVgRPkenPFMDiknnzhr/5GZZ
         xC9507PbK79nm1eYrSz1nvnLiodGo+7Ji6nkBFOsjAANCFoGbTholfJPQQuTvEg/rOG4
         HEpdjTaCD63+fwTrsnghAZSorTJo5VBA8UrMlfjKVzGFbMs83PZxh+rQ5NPtDR8jD6NF
         8ePY5QYqhh/bAWxcy51ZXICBtZV/RIOsPDk5vqzkxuSv+AuvJyqHUc5hzJjomixBnIps
         tvv9Mr9aGtG9uoINyQyiWrhHQtHWsk+nIAGbARFlSqT9BdP6YdafE5IHEmSAkB0zfhHY
         0kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Tss/LNwFImxrLQsqwbSE4FC5/jSi91pDw3mZadacVew=;
        b=dj2AbOFSSzn6bfr6EWSsviUGdgv9/9vjNgMLjq6H2VM1Uju/HePg4Cgs6HeohmJ2v3
         yB4/Jso8nOBYjKctI8TJHT7cqVMAjYBH+0gDv9hCyNy/R+nwdc3xryWldhxpmwoM/rY5
         hW667INegZC1Wuyz/gGKXA8gRS2v+Dw9+n4ZVRwaLq1izOW30AeoTz07bzLAJVQcWMQ3
         uha8gihyF1N0sqvbzJ5QXiE40lTO9sIeO8iNF5v/oUQ5p3QlM6uBWJQKdIfsJ+3HnRyx
         T0oh4p2a2Ngx/IxWqzQHnyv6q9f6UpQVQmAKiV8/jbaZOhjWopVmBVNDY4tqf/p6z2nK
         r2TA==
X-Gm-Message-State: AOAM530ddu4oE0zxPL7+S9UQGOE1YbauiTcX6j1FsSHX/LuewnNZiGnG
        Nj7mBxXd49ln4ui04BdY374=
X-Google-Smtp-Source: ABdhPJxTA3rgsavKQlcAKyzFF8aWYAmTYnxhV76akMaOZP5NJgwHDiE+7qm6jEP/RQC6nr0KO3MA3Q==
X-Received: by 2002:a05:6602:c2:: with SMTP id z2mr17206030ioe.81.1602531922914;
        Mon, 12 Oct 2020 12:45:22 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id 128sm7656531iow.50.2020.10.12.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:45:21 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:45:14 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        Florian Lehner <dev@der-flo.net>
Message-ID: <5f84b24ad1016_24c92208a4@john-XPS-13-9370.notmuch>
In-Reply-To: <20200922190234.224161-1-dev@der-flo.net>
References: <20200922190234.224161-1-dev@der-flo.net>
Subject: RE: [PATCH bpf-next v2] bpf: Lift hashtab key_size limit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Lehner wrote:
> Currently key_size of hashtab is limited to MAX_BPF_STACK.
> As the key of hashtab can also be a value from a per cpu map it can be
> larger than MAX_BPF_STACK.
> 
> Changelog:
> 
> v2:
>  -  Add a test for bpf side
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---

I think this is OK, but just curious is there a real use-case
that has keys bigger than stack size or is this just an
in-theory observation.

Thanks,
John
