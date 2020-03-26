Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD76193F85
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 14:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZNMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 09:12:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCZNMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 09:12:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so7767586wrd.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fYD1onDikuCT88dA5DWTTI0UuhLtnw/htdevMIVPd9s=;
        b=SBr6DW5T+1V0x5iQLwqAaWSO25Rdxc8tXhULBX/bVijGFSDxmpoXqFVFnH5TrL2kG0
         u3v0fs+akUJTQ2RGHrLQGMzCWoi8tpcrJn0prdInLINCiMuritNDPDf7FqpSYQGe2xWe
         hPI2gQ6d+etxyoc1nowSU5Oq+RYuE3OIjyPH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYD1onDikuCT88dA5DWTTI0UuhLtnw/htdevMIVPd9s=;
        b=f93wvoI0bLXm7bNTJ9Q9Vy/ysU+pRSEvEdEaw8ZEEu7PAmB3v17U8WMt4ypKH603AE
         EKuA7lVV/5mpS0uTjj1OvyPPYgv5xv3k5fBSmgfjnVLAPAAQ6U7bgBMBnIJzX7Bvxojk
         l9Vj7Te+vIFe0XJm5Vo3GTYkqAFGyFcC+xP+9xmxV61DoNeQfzmBBSbenyEu4CTFkUSm
         orSD6ZCVFVkqI8SqjIcnOJsMaEcl+EvuCmWYKmomFPK+kI1lKHEl/dDTaHqjOuRyyhPa
         2+fDrxRi11MufJfGvn869CLFCx7iZa3QA1Nv+bG3OXT2pcWmc2QOSPQzuR4I4TedOYmP
         TTEA==
X-Gm-Message-State: ANhLgQ0g2KS4vzmfUVkTaRsUiV+Laek9pLO1lN1cYnQ1iEEIWM0yBrl5
        jlFIWlQy+7tIyG0u3BZ3T7iw5Q==
X-Google-Smtp-Source: ADFU+vsgpQLD/kDSgky4dJcwopfiL6zM9Z6fEVRTGk4Y2ZMQ2fUbqvWhoxQPHg238aypcNRoFGZS/w==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr8872802wrp.23.1585228324428;
        Thu, 26 Mar 2020 06:12:04 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 195sm3563080wmb.8.2020.03.26.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:12:03 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 14:11:58 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
Message-ID: <20200326131158.GA8575@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-2-kpsingh@chromium.org>
 <CAEf4BzYomSccqbO2AGbejQV2R2z0jz5GhEFZxuf7SGwtju+e8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYomSccqbO2AGbejQV2R2z0jz5GhEFZxuf7SGwtju+e8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25-Mär 18:51, Andrii Nakryiko wrote:
> On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Introduce types and configs for bpf programs that can be attached to
> > LSM hooks. The programs can be enabled by the config option
> > CONFIG_BPF_LSM.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> 
> Looks good to me, so please add by ack, but I think it would be easier
> to review if this was combined with patch #4, which adds verifier
> support and kernel/bpf/syscall.c support. On its own this patch just
> adds random unused stuff.

The ordering becomes tricky as we are using the CONFIG_BPF_LSM in
"bpf: lsm: provide attachment points for BPF LSM
programs". If it's not too much trouble, I would appreciate if we can
keep the order.

> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Added your ack Thanks :)

- KP

> 
> >  MAINTAINERS                    |  1 +
> >  include/linux/bpf.h            |  3 +++
> >  include/linux/bpf_types.h      |  4 ++++
> >  include/uapi/linux/bpf.h       |  2 ++
> >  init/Kconfig                   | 12 ++++++++++++
> >  kernel/bpf/Makefile            |  1 +
> >  kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 12 ++++++------
> >  tools/include/uapi/linux/bpf.h |  2 ++
> >  tools/lib/bpf/libbpf_probes.c  |  1 +
> >  10 files changed, 49 insertions(+), 6 deletions(-)
> >  create mode 100644 kernel/bpf/bpf_lsm.c
> >
> 
> [...]
