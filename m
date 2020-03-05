Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6417B195
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 23:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCEWjE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 17:39:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35944 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgCEWjE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 17:39:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so121087pgu.3;
        Thu, 05 Mar 2020 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BH9SEY6sBAAworg6urGASTmP0JolCTW4zXLsv8vx0fM=;
        b=JLlvnkIJTCIJ3NXqKzdDTG+m71bBc5wNzfTmXHmAXbD/kDeCQ9gQZj7mYTrgVSj1wW
         zTeHtEXXkuas0n0KLPVW59kYAxfJQP6nCjGHGXOR+Sc9nCBAlMKLnOEyxhLDd/ebDbbK
         5NbwPhaXVRDInHWzY71pTVa4o0DlFWkD0PQAIU2LGYn2QVreNx3dEIz8t2jJgWkbTIAX
         UAObaMBBBajW9wBmY3F985iGRs/WcIJWyyOrhC4ilqx5xILHa0cDwpuqlzrNSf4kDR2Z
         fjnXNgm9HUrs7964QxZ8bkyNjk6x3/IwR3Y7LqZw7Yt+Zx8oGWml335HLT+x+PSWMguZ
         DoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BH9SEY6sBAAworg6urGASTmP0JolCTW4zXLsv8vx0fM=;
        b=rqxjWBz18ZlNNAU0pB+lUnqijGQhp19d1dGuggCBT/kGB68qOcQDLmO1GqA3y8apao
         LQ2oY6Qgm4naMxcg714tQDIYDyUtOSsuZFgNPz/yJqg8c+QDbk72RrMvAp9KW0yIwyB2
         TrR+PU44uGXlmQsKoCkaTe4P1hajxJQDe+dna0nXs25mEpkH9mG04T8+G03Ke54AAmKx
         BFrpVkC20M5vIVGTnHsfM9QS7R7BZw56snQCEtecsfrxnEMyiwVhSvWIlqkshGrplL30
         I3DKCxbczaTWBaGk0GPQMuei1hOyOj/PSDEdV1MFWh6zaOi7vhAWZg1TDa/oSsK8KQks
         2MMQ==
X-Gm-Message-State: ANhLgQ3tTA9uRY1/Ziw7Od5ol85HZQa2bpR/OqeDKdw4CkNBeDlY61Va
        g2DeLv20i1i2WwmLL3z2Lsc=
X-Google-Smtp-Source: ADFU+vtOChJvtEGPPChwrCfmKZhaaypCWfiV6Jb9Y7N4eDknBWmYPUwlemRkpnNp/0Q2PjhHzhoTmg==
X-Received: by 2002:a63:dd06:: with SMTP id t6mr345743pgg.384.1583447942858;
        Thu, 05 Mar 2020 14:39:02 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:f0e7])
        by smtp.gmail.com with ESMTPSA id h29sm30356632pfk.57.2020.03.05.14.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:39:02 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:38:59 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next] bpf: Remove unnecessary CAP_MAC_ADMIN check
Message-ID: <20200305223858.qprrtu6jfbaqt3bk@ast-mbp>
References: <20200305204955.31123-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305204955.31123-1-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 05, 2020 at 09:49:55PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> While well intentioned, checking CAP_MAC_ADMIN for attaching
> BPF_MODIFY_RETURN tracing programs to "security_" functions is not
> necessary as tracing BPF programs already require CAP_SYS_ADMIN.
> 
> Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
> Signed-off-by: KP Singh <kpsingh@google.com>

Applied. Thanks
