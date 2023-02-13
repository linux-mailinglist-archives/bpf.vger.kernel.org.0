Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74A9695061
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBMTIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 14:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBMTIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73799E06B
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 11:08:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52ec987d600so108722587b3.21
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 11:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfENp7GXAHAS5dlD7KtGQG7FDhBo3iwREQeMgTHPHVk=;
        b=VKzey+frDU4g6flLpUe9iLQBvs7lO8H3LST8Vox1VmXu0wo5VfSkLpyLJyYWQvQulK
         I5X1fFqnO3bfoglrh7EnPh4tKSRhFbV2HcmBhdSZY8WGzeb7Pa7HHRuuqr+EQeBoLDd1
         2uE0tJIX2cYtgXc3iBaloR2hS2T6AEV4dLL68NKjdpIRGYqfjsYIAv/h+8Qx7qUgpnnD
         kA15TU45fS0m1IIR6CXuG5p68G6GqnqJUfPZvg0NwKs66qtFg6wqIl3OjQfxB8E0TZ9/
         AZIycPc8UUsr9q6cV9c3vDyLIdZp8pesCpSKvPcnBwsWxLBVv6YngMzBtMDpYVqNoagx
         vPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfENp7GXAHAS5dlD7KtGQG7FDhBo3iwREQeMgTHPHVk=;
        b=pWINmjkbkplhQ99BtR7Ki7ieIOtL4qJjdyP3pmvASMUK1npjXckHtlMON+YEnq8qkf
         9jGTfeNewzJg+E2Is38qPRTIRpHqZ9z9EyBmuMDWVn2qEbVvZSOBh25bb+JbnldZPYdt
         QuO2qOxEWfHmBIz4fnV7M/PzHOTFye3WpXj9Sis9V22VvspPlhZbLq7XsQmdOmOos9X8
         eIgCOBdjP6/A/lHDkVYjD8bf0FPJT0FqrNI+mQhczWAZ3sM7Gk8sw72PYX2qYTqOMuiU
         MkTOmqQ01AK/hBEtn51Rsy5bebmBvP7cte5Y/wugzSo+L2mPNfiESE5dbRafZ1irQVk0
         SRDw==
X-Gm-Message-State: AO0yUKUPK7pjeHny4y0aTZL1teVd2mjRR+rL5Q0v5wXHI7x/LeorxNTc
        fjYzTLUEzswbDHv4LIKR/rTuFXY=
X-Google-Smtp-Source: AK7set9kzrcbfzTw1+x98fyKqHo4eKKMB+w8vwwbBgpBw3Dm/tr9odTRtvNo53X07BHC/ZWstH6UT+Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:f843:0:b0:500:ac2c:80fb with SMTP id
 i64-20020a0df843000000b00500ac2c80fbmr2983101ywf.90.1676315279612; Mon, 13
 Feb 2023 11:07:59 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:07:57 -0800
In-Reply-To: <CH2PR21MB14309C209861239DB568C3C1FADD9@CH2PR21MB1430.namprd21.prod.outlook.com>
Mime-Version: 1.0
References: <CH2PR21MB14309C209861239DB568C3C1FADD9@CH2PR21MB1430.namprd21.prod.outlook.com>
Message-ID: <Y+qKjbYJV7WhiSYA@google.com>
Subject: Re: Proposal for patch - Extend bpftool prog run to accept cpu and
 flags options
From:   Stanislav Fomichev <sdf@google.com>
To:     Alan Jowett <Alan.Jowett@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/13, Alan Jowett wrote:
> BPF,

> The existing bpf_test_run_opts structure exposes additional fields  
> including "flags" and "cpu". I propose extending the bpftool prog run to  
> accept options so set these additional fields.

> Use case:
> Some BPF programs access state that is potentially shared between  
> programs running on different CPUs. This can impact the performance of a  
> BPF program. To permit users to more accurately assess how their BPF  
> program will perform when being invoked on multiple CPUs in parallel I am  
> proposing adding the ability for bpftool to set the cpu field in   
> bpf_test_run_opts struct when calling the syscall.

> If no one else is working on this or there are no objections, I will  
> submit a patch using bpf-next https://github.com/xdp-project/bpf-next/.

Patches are welcome. I don't see anything controversial with extending
bpftool with those extra fields.

PTAL at [0] on how and where to submit the patches.

0: https://www.kernel.org/doc/Documentation/bpf/bpf_devel_QA.rst

> Regards,
> Alan Jowett
