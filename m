Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC53A4BE0
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 03:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFLBPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 21:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhFLBPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 21:15:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899BDC061574
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 18:13:11 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so4939495otl.3
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KHipPYRZ4uATvkcpMUfSP44douiaEMPmq7tpq4EMPvI=;
        b=RZ4qX0dt1Z4pXPPpknRmxfsbcNinDdRNVQxX/g6Ke7AC5LuVPGT7pA6Xv+rXkCC/9/
         sUT8vZv3HL1XWUwMNCXH3htct1pe3GA5oZbL2aMXPu+fVGCvo4BFnkZOlmXvXuIksLSv
         8pbABMXB/kYcZ7O6TC/K4VoM8PRiOlDGipLeBuaxe9nvi68gRt1Di837/sy5Mrn3C1MD
         f4i1pVsDReukzX+ly79qR+UIEfcie3USIuysSvXMEETNUCFRmgFuf54nslT8rzP0wMRK
         70xqwREAGYeuwagXSrfCIucNe58rPupLLJMwYmrHEXg5oYQXtKSzbtayfntHG0jxYN00
         3ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHipPYRZ4uATvkcpMUfSP44douiaEMPmq7tpq4EMPvI=;
        b=dSyZ5AWRFEDxBT4OhucFGYCFDLJWhxiRRivdg6C+F0SD0N6CI75Skym8qIlIC0a5fx
         8HUYshGB7uU+hm/qq6BT1O8wWwmpYySOcHGvK53uWDcrXDDY7ZcOzBVHbDFEtAs5dXHC
         g5Z5puFUvxA9kNsCvPPHQwuuk+Zrsuz6/Si12OK+LdQIWCNVxbhqqBxkCm19GvLJz5IZ
         y9HAVVBFkKW+4u3VbMwlgWISAYOK2xNFcDzPa+OQqOXwUnBqXsydhhQwIC0ypD8ZVLn/
         mP9BIfXSue0g4UGn21lRIbp3qGnES9oLpDJbihloShuR8A9xmuBKkngS9v5pYuM8Z6rf
         w9Ag==
X-Gm-Message-State: AOAM532pjSWFR+rqgZafGhOHO8o+I9fjo6nJBl62ZWF+2gpSN6bM5kzI
        yL/4yiO0TCxw8/zu5mpCh8ulKcCvE8w=
X-Google-Smtp-Source: ABdhPJxxtHRiTlTuyWkOhl4bn4o/fAA2erZOG5yrL45/CUXCS2SlpBKDwteNMKuk7UkxIlUiS8eZ8g==
X-Received: by 2002:a05:6830:22ec:: with SMTP id t12mr5270706otc.243.1623460390629;
        Fri, 11 Jun 2021 18:13:10 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.22])
        by smtp.googlemail.com with ESMTPSA id s15sm1541038oih.15.2021.06.11.18.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 18:13:10 -0700 (PDT)
Subject: Re: bpf_fib_lookup support for firewall mark
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
 <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
 <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com>
 <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
 <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com>
 <CA+FoirARDoWWpif2tw47BG0Rh5+uBpsoVZ7Y05JnZO2UqBDSEw@mail.gmail.com>
 <CA+FoirA-eAfux3PfxjgyO=--7duWCKuyeJfxWTdW6jiMWzShTw@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <ae33242e-25c0-744b-6060-4cdecb32e3dc@gmail.com>
Date:   Fri, 11 Jun 2021 19:13:08 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+FoirA-eAfux3PfxjgyO=--7duWCKuyeJfxWTdW6jiMWzShTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/11/21 5:56 PM, Rumen Telbizov wrote:
> Hey David,
> 
> I just tested your proposed patch and I want to confirm that it works
> great for my use-case.
> I get the same rule-selected route based on firewall mark as the outside
> ip route get ... mark ...
> Also since we didn't touch the ports, multipathing works as expected -
> gives a different route
> based on the hash of the socket tuple.

great.

> 
> So having said that I can't help but wonder what the next steps might be.
> 
> Are you able/willing to incorporate this work in the kernel?

I do not have the time or hardware at the moment to do the testing - or
create the selftest for it. If you do have the time for the selftest, we
can tag team it.


> If yes I also wonder if it would be possible to backport it into 5.10
> branch?
> 

5.10 backports are done out of tree, so you are on your own there.
