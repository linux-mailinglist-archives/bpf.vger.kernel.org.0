Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8528A66A7E6
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 02:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjANBFb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 20:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjANBF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 20:05:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4DB0C
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:05:28 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g205so277678pfb.6
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 17:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GOyDWKZWciQEv4hIBWjWekaZNIz+f9SPWHV9A5fcEIc=;
        b=QkfPBd5oa5l3uvPi+bt/pKLhGLP8LeLhdqoGb04NeutdZHBJSKJu4V8fPgwGq/eLFT
         gJnqtTGEQEbfIg57z4reUhlpOsB9usbiuohxD8HIm3QkW2ey6Fuya+gN3g4DKMYILrMK
         gqlUkuh7UOSyWa+Fsl/7Vo95lTnjrVJHOTI71sYqxUxKx2ltwcy+zv7oQYeHb7/FW+Er
         o8LVzW71mJOod1xAls2wlYyy4ENh6JFW2zga3HtFQRtWwKWTaMbfItmr8AgPkfengK05
         /5ZWmPmObq7w86AlWUh1EGkjuhjfdUxPA/TK2s4oarrDyYrN0ChVTjvKt7JMkoS6zPbQ
         b/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOyDWKZWciQEv4hIBWjWekaZNIz+f9SPWHV9A5fcEIc=;
        b=U61ZZlQF6B34ccnG4cTsacj7wbv5NlcwUn7yp2t9SlX2DNB4d84iGXrL6xjoOW3hYF
         2IofEatJUWr62oNVozfkSNIJzCGSSCNHnSMip7b0xzxTBXc8eNUFlxktgQIv4pOo0bn9
         mRY2a5g2BOSfuth7szvqG2D3uE7Z+fgpdkGJo5QF/LnNo/yKjZWZsLaFBUcF5yfpPb42
         0N4wQPD8P+VeKw+bM+g9H90kxiGffFYyTKHcT12hDjKMDKqT5I+ARqZpy5Y7jr/Cgkvf
         5+KDkIJI/Ny38NlO0GK5niho26vhCs8MLtEE21pfnP3mGCq0/gca9nuTs33ygM24J6MN
         DdqA==
X-Gm-Message-State: AFqh2kopPY154KGNX6M6APZk5or4f+CMLob0QfZrevCfyC118CgpQ1Uu
        oRqDw9M/DJZh56VQAys0nC/AKaem6Ma669pjh9FTFCgLhm2fed4r
X-Google-Smtp-Source: AMrXdXtu0SV1k20WxYz0JAveV3IzdjSEYlBb3tyatNctpMum8yiYPA1qHTdI7G611H5r0NWcv9iwJh6bYMNPdbfnEus=
X-Received: by 2002:a63:561d:0:b0:4b1:9148:6bea with SMTP id
 k29-20020a63561d000000b004b191486beamr2272494pgb.320.1673658327352; Fri, 13
 Jan 2023 17:05:27 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 13 Jan 2023 17:05:15 -0800
Message-ID: <CA+PiJmTMrWq-BGAMZgd317q0sT7tN-6=r3sDbZdb8iVzwPKdsw@mail.gmail.com>
Subject: Struct_ops Questions
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm currently working on switching Fuse-BPF over to using struct_ops,
and have a few questions.

I noticed that the lifespan of the [name]_struct_op struct passed in
reg, and the associated maps have a lifespan that can't be influenced
by the subsystem. Fuse-bpf keeps struct ops on an arbitrary number of
inodes which will potentially outlive the op structure. My current
plan is to have fuse treat unreg similar to if the daemon simply
stopped responding, failing all impacted calls with ENOTCONN. I'm
currently looking at two approaches.

1. Copy the struct received in reg, and have a flag to indicate if the
structure is live, with unreg just marking it as dead and some RCU
style sync to ensure we don't lose the function pointers post check.
2. Maintain an additional struct that points to the reg provided
struct. Null out that pointer in unreg, with the same sort of RCU
sync.

I'm currently leaning towards 1, but not sure what the best approach
is here, or if there should be some way for the subsystem to grab a
kref on the maps/struct_op structures. Given the analogue of the FUSE
daemon being able to disappear at any given time, I think one of the
above options should be enough.

The old fuse-bpf implementation, which had its own program type
defined, would use the program fd as an identifier, which allowed it
to increment the ref count as needed. That sort of information isn't
exposed to the register function, and you can't reach the struct_ops
structure from a map fd as is. Either of those would allow us to
directly use the map/struct objects without needing to maintain an
extra layer of duplicated data. Currently all the register function
does is add information to be able to check if the map still exists,
which wouldn't be needed if we could just grab a ref.

I'm not sure how to handle Fuse being built as a module. Currently,
bpf_struct_ops uses an include file list to define all available
struct_ops, along with externs for their bpf_struct_ops structure. If
we build fuse as a module, that either would not be available, or
would require us to build extra things into the kernel when we make
fuse as a module, which sort of seems to defeat the point.

Do we need a module interface here? At the moment I'm messing around
with just having the reg/unreg functions implemented within the FUSE
module, with all of the verification functions built in on the bpf
side. I've got a rough prototype working, but there's some messiness
around unloading the module while there are still struct_op programs
registered. If you unload and reload the module, the struct_op program
will still show up via bpftools, but would be unusable since it would
no longer be registered. All of that goes away if we can directly use
the map fd as an identifier. That wouldn't be useful for anything that
requires extra setup in their reg function of course.

It seems like a fair bit of these issues go away if we allow for a way
to grab the specific struct_op structure from the map fd. Would that
be a reasonable thing to expose to a module?

-Daniel
