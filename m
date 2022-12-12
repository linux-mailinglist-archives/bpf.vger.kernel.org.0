Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30E364A5E5
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLLRa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLLRa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:30:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEBC13D53;
        Mon, 12 Dec 2022 09:30:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h33so8658017pgm.9;
        Mon, 12 Dec 2022 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z21oFf4hiNfGZLeV4FQGNgyqzNhNukArWrfGuZ2kXxE=;
        b=fYyWL89qvDzB+n35SXpfDREOWwebQjkmJSh11aLnumLPAOMIlNWoCTxpszLnjVBRMq
         mOl0mDkof3p+6z97nqE1CVyek85GYi2sO7YZnydLCiwh/Rs79B6sVa+0smWyizFqEei4
         7hStEJ9Up/UmoHX5823F/W8XT+Oge3g4OQUOwb9VPS/Ntkq5fKW4JsDtyAeHAcWmd8xe
         6M324v1rSTVKj1+S3GUaKyRDXA5q5utZuAG2KP1kyB4hiCG3NjVLsLtVVdjInfHqPP4T
         2NVD8Kx+RqddXD0xuCa2fgH1P1AdWm9SKB/V+4cPmvhAoATX3ABdP83CarzIwMktv0UI
         FlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z21oFf4hiNfGZLeV4FQGNgyqzNhNukArWrfGuZ2kXxE=;
        b=SRWYN7U6dTuBTjNk9DoL5x9/gxyULwKbikWJVCFy6nNdBeMF8Ul/Ux41yP5TFBP2iC
         D7KaJLnJoUe56zqR9C4Z92gs8M6mx1uW7oKBO4IiAgadsu2j6frRq4YNGf7MfI3FiXpC
         tmiKYBX4joCZY69ecIrXBDW9yUMs4YN4mk7vf4eiuWcWnx9fZufj7eDmgcAiHjuejd7W
         M7JI17ypo/L6uzDTa7vlXZ9QHHF9TvxQlhrTsFrr3Qb5Rr6lSGzX4mmrdbgz6Og5peMJ
         IGN7H03QVKRTO7BUv7X4Q8wiac3nl2NOFGAXDSiYdX2acziUVrfvszECoDayABJZ0tP7
         h+kA==
X-Gm-Message-State: ANoB5pngZ5FYpDJIEhi2+NDiOEenucfhKTBZ0EAXSJQvwGFo4NsfJkD3
        aAjlAhL/YFfntC7wk6qX/Ik=
X-Google-Smtp-Source: AA0mqf79PJUUTIbm1rLnzANIG1629MwP9xK5T4YbhypK0qLEHgJ3hmEPNzKQzKrXhz1gMgeWc/OoMg==
X-Received: by 2002:a05:6a00:1a0d:b0:574:8985:1077 with SMTP id g13-20020a056a001a0d00b0057489851077mr21560719pfv.26.1670866226673;
        Mon, 12 Dec 2022 09:30:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id k76-20020a62844f000000b00576ebde78ffsm6044740pfd.192.2022.12.12.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:30:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 07:30:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 28/31] sched_ext: Add
 Documentation/scheduler/sched-ext.rst
Message-ID: <Y5dlMFef6xMMtWpW@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-29-tj@kernel.org>
 <Y5anpn997mR2g8Ur@debian.me>
 <Y5bKGXG0o4dReJ8C@slm.duckdns.org>
 <fd419b09-4514-7785-bd72-f912d0fe85c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd419b09-4514-7785-bd72-f912d0fe85c8@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 08:07:32PM +0700, Bagas Sanjaya wrote:
> On 12/12/22 13:28, Tejun Heo wrote:
> >> No patch description? Really? Please write one.
> > 
> > That's unnecessarily grating. I can add some blurb but here's an honest
> > question. What pertinent information would the description contain that
> > shouldn't be in the doc itself?
> > 
> 
> Sorry I don't know the answer, but the description should at least
> expand from the patch subject.

Yeah, I can put some filler text. It just feels a bit silly. Not a big deal
at all either way.

Thanks.

-- 
tejun
