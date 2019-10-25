Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD9E5150
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfJYQep (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 12:34:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44067 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfJYQeo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 12:34:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id z22so4099669qtq.11
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZzuMoUW9nL3txMEdTJ9XgUATvp+vohOFem7VSLZndxM=;
        b=V6loMynR51IXK5Uh3Uz8hul19FqYBOTdlPifpgqSVEAM1F4ObmQBhZau93eB5N2RnN
         nhplMUwzSOmoSFF+fCBbJSnX0wN0ItnKnoUaEeqFE9mwZ1UqxOkX2KuuwZoS4qz3NtlE
         dE5jxh5cmxNZNz7a97C85o1qoa7sCG2iBo1mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZzuMoUW9nL3txMEdTJ9XgUATvp+vohOFem7VSLZndxM=;
        b=g42wkwBmxzkfws+WNPMKv1/RPj3dbcTzJ7UepaEA1Im/qvS/Q7PoS3YrHWajpuIFjX
         X/9e8QKcjcD65F1WcnDhtlwz2LT5xfCJK8JSqrJg+zWGzNXPTQYLjSkIMmVF7rk79yfc
         JD//O1jsC0sbx2eaAaUoSHwcFgCKVOV59QrMjrZD0EEnw/PoOSBHr86H85ZJVcGqcg9Z
         cRa3iVzY7uOnfeiTtx1tO7aQR0kokLPKE38N3V+ywyZPWPAhqRITM/E5gmXbDLoT2hFB
         dcmUESEiNll1jNfO/NB69rjnOiQcO8LkN8r2swHyyHpg5iclS0O4wEpeh+AODUWoHLfR
         ed9w==
X-Gm-Message-State: APjAAAUA6TDeUcMlxvBW7AFsI019ZBLuu6b17Uwfiz2bPrwxHGVlcYbZ
        tPEez8Mir/gZppvz4YcEPJS4sA==
X-Google-Smtp-Source: APXvYqzjx4j/H27n5mz467dFdm+fjNZTliMh4eTlmkmw+XDgygL3bwC15sAnxfIhgOfBLnHeWtCDrg==
X-Received: by 2002:a0c:95d2:: with SMTP id t18mr4258748qvt.50.1572021283754;
        Fri, 25 Oct 2019 09:34:43 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id m63sm1327855qkc.72.2019.10.25.09.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:34:43 -0700 (PDT)
Date:   Fri, 25 Oct 2019 12:34:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, workflows@vger.kernel.org
Subject: Re: patch review delays
Message-ID: <20191025163441.idjzlnwahoacnhbp@chatter.i7.local>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, workflows@vger.kernel.org
References: <CAADnVQK2a=scSwGF0TwJ_P0jW41iqnv6aV3FZVmoonRUEaj0kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAADnVQK2a=scSwGF0TwJ_P0jW41iqnv6aV3FZVmoonRUEaj0kQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 25, 2019 at 07:50:22AM -0700, Alexei Starovoitov wrote:
>The last few days I've experienced long email delivery when I was not
>directly cc-ed on patches.
>Even right now I see some patches in patchworks, but not in my inbox.
>Few folks reported similar issues.
>In order for everyone to review the submissions appropriately
>I'll be applying only the most obvious patches and
>will let others sit in the patchworks a bit longer than usual.
>Sorry about that.
>Ironic that I'm using email to talk about email delays.
>
>My understanding that these delays are not vger's fault.

If you're receiving them at your gmail address, then it's possible 
Google is throttling how much mail it allows from vger.kernel.org. At 
least, that's the usual culprit in my experience (I don't have access to 
vger, so I can't check this assumption).

>Some remediations may be used sporadically, but
>we need to accelerate our search of long term solutions.
>I think Daniel's l2md:
>https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/l2md.git/
>is a great solution.
>It's on my todo list to give it a try,
>but I'm not sure how practical for every patch reviewer on this list
>to switch to that model.

Remember that all lore.kernel.org lists are also available via NNTP, 
e.g.:
nntp://nntp.lore.kernel.org/org.kernel.vger.bpf

I know some people can't use it easily due to NNTP ports being blocked 
on their corporate networks, but it's another option to receive list 
mail without waiting for SMTP to unclog itself.

>Thoughts?

One service I hope to start providing soon is individual public-inbox 
feeds for developers -- both for receiving and for sending. It would 
work something like this:

- email sent to username@kernel.org is (optionally) automatically added 
  to that developer's individual public-inbox repository, in addition to 
  being forwarded
- that repository is made available via gitolite.kernel.org (with read 
  permissions restricted to just that developer)
- the developer can pull this repository with l2md alongside any 
  list-specific feeds
- the hope is that the future tool we develop would allow integrating 
  these multiple feeds into unified maintainer workflow, as well as 
  provide the developer's individual "outbox.git" repository

There are some things that still need to be figured out, such as obvious 
privacy considerations (public-inbox repositories can be edited to 
remove messages, but this requires proper hooks on the server-side after 
receiving a push in order to reindex things). It's one of the topics I 
hope to discuss next week.

-K
