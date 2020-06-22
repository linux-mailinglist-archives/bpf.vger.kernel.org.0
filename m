Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89443203A7D
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgFVPRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgFVPRI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 11:17:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA4C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 08:17:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q2so14641309wrv.8
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qCeAhT0j4Xt2n79DhTOAMVll18eLiNHIwPbPSkmp1Xs=;
        b=kigM39HlxeK35791BoNz+aBa8IQZ55UZRT54rbcmrs9bCAUpdkhz2DMTt18QqSQIO9
         iPD49X4FkMVBfj6fdwQAVOTbWkOzHzDO9DnQcPVaD5w7mRtMoqnlD5F9diwUvi62Cqnb
         ls/qSLXK4tB7Z7n/ktZFAUkB8++TxblBqnKyAmXnLuBumU57dCXoZq0+ADnuK/ZBOkGO
         TFSmp7ndvHZc4VnBHaJJ2Lzb6u36uZkShXCoyTIDmNI5mdqmWIDZoOoWP1E+wQquTCiE
         3Uep5wsRYE6zJL4g7EJ0YSgsSJXnt2ALxj7EFm8SuDVjQ+9+L62pp7P8edlmsKY3DIIN
         BhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qCeAhT0j4Xt2n79DhTOAMVll18eLiNHIwPbPSkmp1Xs=;
        b=bwg+8ZfNtIavJDp0jmD0CKtiUTi0FSpoorUPkesdYQaTB+QgssahSNw0X6iOlEHdCn
         QTuO3Xzxa+2aHFkQyhmVGKRtBO1vwE2aRFTpYZ/Q16WOxEClk4huCRaK5iTMsyz+Y6MH
         phmsC6TkHGfj3aO4ZhtNGub43vSFK2sIB268wXE39f4hlQt9bxbzQw3UPWcp3fTP/zCw
         OaCUtTZwrrcrnVHF5W6O/B7HlYOY6rBxcod9lvjofmV65HdHpyjHHC9y8MWVd13HA+1H
         15YamLrOi4DwLJcLTqk70Wkthgesc0aSYS2tdorVIxRBDXNwpHNw2zZp8Wa6EuoPNX5T
         KB7w==
X-Gm-Message-State: AOAM531lvl6ZQsHCG95mf775yBdux6jP2OnrRyN8pSC5/ln9olB3uCR3
        gZrabeHCEUum0+TpfnVxXa0jXQC6SW7V3w==
X-Google-Smtp-Source: ABdhPJz5L07ZYUTeoL5WHAd5f218eoDLzeaQauA6fgM1WyKnY++rohfo9hMGa7q+zQEcjObNxmNlmQ==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr15913611wrj.336.1592839025582;
        Mon, 22 Jun 2020 08:17:05 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id u74sm17652456wmu.31.2020.06.22.08.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 08:17:05 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools, bpftool: Define prog_type_name array
 only once
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200622140007.4922-1-tklauser@distanz.ch>
 <20200622140007.4922-2-tklauser@distanz.ch>
 <c961c0ee-424a-6f3b-942e-42fdc7ee9b95@isovalent.com>
 <20200622150510.nk6pkzsof2diolwt@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <2df810b0-b31d-641a-9d81-47eb11c3f0a4@isovalent.com>
Date:   Mon, 22 Jun 2020 16:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622150510.nk6pkzsof2diolwt@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-22 17:05 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> On 2020-06-22 at 16:26:17 +0200, Quentin Monnet <quentin@isovalent.com> wrote:
>> 2020-06-22 16:00 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
>>> Follow the same approach as for map_type_name. This leads to a slight
>>
>> map_type_name looks unchanged in this series, could you please check
>> your commit log?
> 
> Yes this patch intentionally shouldn't change map_type_name. The idea
> was to say "do the same thing for prog_type_name name as is already done
> for map_type_name". I can rephrase that to become more clear if you
> want.

Ok sorry, I thought you meant map_type_name had been moved to reduce the
size as well. I think I got confused by "Follow the same approach",
since map_type_name has always been in map.c, but it's both
prog_type_name and attach_type_name that were moved to main.h from their
original files some time ago (so not much to "follow" from map_type_name).

Anyway, minor confusion on my side, no need to respin just for that.
Thanks for the clarification.

Quentin
