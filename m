Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5612732C206
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhCCWyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:54:18 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59013 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387995AbhCCUOQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:14:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C6BF5C00CA;
        Wed,  3 Mar 2021 15:13:30 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Wed, 03 Mar 2021 15:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=pQCEuIPC2sx/i+7UGw5P3DBED+FdaFS
        LpF8U1qk8xSM=; b=dqxSPUmmtE87pwGYNhV0BXjD7cBY3VpMMSbx8bCEHVoyfxM
        GAjAndNwJwqlfLUGh8OoaMlFDacfEiI1w9hSAoTdtkqjT3N/28Jdx1alXjAs83uT
        2L6XHXKijJ4BVrQG5/VytGL3FjIMmZY5SglMGOdmfq3GnW+1avc95aqX6gIpaRIT
        TTg8kApCXlUYW4IEKaiIvj+uUuAcNJjbzkgpXEZhCvK5p1CXUGBPjOm7Zoj8/vWc
        wGohrSMxvFESZbHkart0AGC9Ee45T14g/Q6c07jeLBFYeQgdHf2gMTt9IG8abCbw
        KmlP9jPDiUTEQdm3mFLhZQBuEqIMmnCrhBae4/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pQCEuI
        PC2sx/i+7UGw5P3DBED+FdaFSLpF8U1qk8xSM=; b=l0ptPrnX4g3VDFMSHcVPkc
        7RYCyG7EUu2NgcSDo27+7pT+P+tKyrCFerIDzHs2MZvRfdfrLJxgNsw8KpExp7wW
        Q/ANlJ+Ke/+XrinrHuBCfU7PaSuzQI3SbgX4feHDs/+BXtugmj9M7YlGuP8fCC9d
        NvztACH5vyGCPj6WDoLi9hkuHBpAUcPGNkileXeymW6IFUS1FDSQvZbkGjh/zceq
        jpHJzeNsdcAT7fk4PRios98cyxsbCsZa11gDHlm8QUAq6xQIueh6+8jIx1q6Y3J8
        /uXpg2ceaD9NEGGODiKk8HADRiaA4xomSbfYJw7jBJO6Yh4ezzoxGvxGGOCca6lQ
        ==
X-ME-Sender: <xms:6e0_YC5BXlgKSeXLhfB8N6Fsqyx0R5gOZ1Shg8UZG4xggqrTE7LzXg>
    <xme:6e0_YL4wD5GsKrdEHiR7r805_fD9IVhwgvrTZZ68-ApjTQ0a5EIKWf6wuuoglWvq9
    I9tkeMz0P8pA6OtGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtvddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeejgfevtefhjeelgfefvddthffffeeutdffgeeihfek
    teefheffgeeitdeifefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:6e0_YBfNyhMIxs4FH38r5LL6P2uB17EX1ZtWyKRGQ4XiqSDNYCe4Jg>
    <xmx:6e0_YPJos-kDgjx_smw3xERNrloQnJlJIEGIWF3eN76FB5eprEQxEw>
    <xmx:6e0_YGLfCImVtHMzto7dUqgOGWGs2fZwpkjzrFqyxBGeUspmbIB11w>
    <xmx:6u0_YNW21xBafSNm4uk6n7a3JMsRVt39S8ZpYX_3Z-MSnH5bJcWKlQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F85115A005D; Wed,  3 Mar 2021 15:13:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <4d68e8d9-38b0-4f32-90b6-1639558fce51@www.fastmail.com>
In-Reply-To: <20210303195812.scqvwddmi4vhgii5@maharaja.localdomain>
References: <1fed0793-391c-4c68-8d19-6dcd9017271d@www.fastmail.com>
 <20210303134828.39922eb167524bc7206c7880@kernel.org>
 <20210303092604.59aea82c@gandalf.local.home>
 <20210303195812.scqvwddmi4vhgii5@maharaja.localdomain>
Date:   Wed, 03 Mar 2021 12:13:08 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Steven Rostedt" <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>, kuba@kernel.org
Subject: Re: Broken kretprobe stack traces
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 3, 2021, at 11:58 AM, Daniel Xu wrote:
> On Wed, Mar 03, 2021 at 09:26:04AM -0500, Steven Rostedt wrote:
> > On Wed, 3 Mar 2021 13:48:28 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > 
> > > > 
> > > > I think (can't prove) this used to work:  
> > 
> > Would be good to find out if it did.
> 
> I'm installing some older kernels now to check. Will report back.

Yep, works in 4.11. So there was a regression somewhere.

Thanks,
Daniel
