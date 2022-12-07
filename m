Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF7B645E4E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLGQCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLGQCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:02:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E432BAB;
        Wed,  7 Dec 2022 08:02:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B617261AC8;
        Wed,  7 Dec 2022 16:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1368C433D6;
        Wed,  7 Dec 2022 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670428938;
        bh=uMOXr6asjMdriSGzhh1L9jUcP/oV+ntlK5yoRVR1d14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ssf2VM6aWopVI15Ca1rw1MvKdSYqXhn5m3yBXpsDE2faRXmLniOu0wTYPouspelBs
         dmsh88Z6jfbtwZOrYsQmUslXoTaQ3OBUSrqqlKoqAQd6c4x8gQr5B9FbI4y4ytdQm4
         Y3i7EOkuSkrvjk/BQvmhcxAWaEEldc+r3REsAGyE1Ggsdk2/H/Hx6nMEEzGJq7EIor
         LYd48QJxRA4w8IQYsR1B0SEuvqe6jbexIgxL9UvNX3JVGc8AcxydsYXDGsC+45U3XR
         aSyim+dyPcXEdIQqyYITJc1sCjSxHkb28/gGkRrONG6GVZ+gPi0HtsN4xfskWsgBql
         KAjaOXyCRtCPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB02240404; Wed,  7 Dec 2022 13:02:09 -0300 (-03)
Date:   Wed, 7 Dec 2022 13:02:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [ALMOST ready] Re: [PATCH 2/3] perf build: Use libtraceevent
 from the system
Message-ID: <Y5C5AZ1YfthY0tx2@kernel.org>
References: <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
 <Y5ChXjt0uv/yDNwV@kernel.org>
 <Y5Cjylv9dJh796dw@kernel.org>
 <20221207093958.09ae35c2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207093958.09ae35c2@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 07, 2022 at 09:39:58AM -0500, Steven Rostedt escreveu:
> On Wed, 7 Dec 2022 11:31:38 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > No distro I tested so far has a package for libtracevent in is default
> > repositories:
> 
> Not sure what you mean by "default repository".
> 
> At least on Debian testing, I have libtraceevent-dev available.

Right, I'm talking about non-bleeding edge, distros that are still
supported. I'm still checking, fedora is ok all the way back to 33, wrt
having libtraceevent available.

- Arnaldo
