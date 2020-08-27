Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0A254AA2
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH0QYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0QYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 12:24:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90135C061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:24:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u126so6403354iod.12
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QB2H2Mud1LSiOyKZ4gCs+ycxPuBgFStYdT19tKjWaC4=;
        b=WND1p+6KWmJeFU1fkwOcAhLlGNcjHANTbszl1cD4p4heXCC8MDOCGo6nIoKYcngoyc
         DE2ytZJNvgRVQxI7QFsBVdjn52AQJ3L/cT+8byHgifSpeDHnIkBMfNZmlZXXBauk86Da
         1GwOz/p33Y94Amo1D86bhdfA3QHz3+7tSGt02KPohD7pxj5GZVYh83xPQ19RgBSdqfVF
         vFciRjhZUyY0YO073w35hLL7c7aX1a3YpzQZwCIywnzGDvO/cPuZ1vEdNTpLCks8n8eG
         vCOtsPxBebvdi42kU446TigRcyKJI9IPAsqJP2EhsETYmMEJKufC2yo57U7rEugDgwuA
         zP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QB2H2Mud1LSiOyKZ4gCs+ycxPuBgFStYdT19tKjWaC4=;
        b=ZTRTQ6LyIVDLy5mbMzVd+0NKWe+rsdmIzD3jXvlaRwZl6e1QMXTUuHUVdENFY8R+HV
         xSbil4V6AMVsz855JAfOPrGUaP/HYC1cb6MS6WPO8bDZ7H9GF//YUiCGJNEEuCFhNaPW
         oDUfATlIIdWYV3wXWV4Tq9UA0rP2LUjOzGINOkDYvw2woiuO5/6cH1Dfuttqo3PFlcm6
         5E7cqACcmD4gcOaR5/yVFRFQT+HRGbeR67W/p+7KWcCWRJ0Fl1SRSmMmAfaZ8U2O+5vq
         M/TcoQU0+XtEeUPyA47uANFqHajepApeOehrm8JZudFULXgFoF3trqYm50pOcCkqGyo6
         Eq6g==
X-Gm-Message-State: AOAM532jUHFaGMFmXmk08oj92ovAEYKBGcVnj4hn1mu0JKTVObcI5LTW
        GYPR7nB5vr0GJps4xzxcWupt25QWdgrAIA==
X-Google-Smtp-Source: ABdhPJxE2XmElptcVbDBi/35dfpbqBeM/YGAeTdGqhbrj9DXqQ4tsGx7bBbbJJ6LHMjBPAlFcb2e8g==
X-Received: by 2002:a6b:8f10:: with SMTP id r16mr9144691iod.165.1598545447354;
        Thu, 27 Aug 2020 09:24:07 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([2601:282:803:7700:3005:f69c:3e46:66e5])
        by smtp.googlemail.com with ESMTPSA id u25sm1356795iob.51.2020.08.27.09.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 09:24:06 -0700 (PDT)
Subject: Re: Frozen Maps
To:     Abhishek Vijeev <abhishek.vijeev@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <CAHhV9ERe4VwPrrwDJF4xqmaeyqQqPvYaY2Wb9DEk8tf-GB_-Yw@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <b8a11771-7b7c-a3b1-0639-dc4706ef3ecf@gmail.com>
Date:   Thu, 27 Aug 2020 10:24:06 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHhV9ERe4VwPrrwDJF4xqmaeyqQqPvYaY2Wb9DEk8tf-GB_-Yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/20 9:59 AM, Abhishek Vijeev wrote:
> Hi,
> 
> From a user-space process, given a BPF map file descriptor, is it
> possible to determine whether the map is frozen (with BPF_MAP_FREEZE)?
> 
> As far as I'm aware, the only way to retrieve information about BPF
> maps from file descriptors is to use BPF_OBJ_GET_INFO_BY_FD. However,
> I do not see a field which tells me whether a map is frozen (or not)
> in struct bpf_map_info
> (https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L4035).
> Kindly correct me if I'm wrong.
> 
> Thank you,
> Abhishek Vijeev.
> 

fdinfo for the file has the frozen status (cat /proc/$pid/fdinfo/$fd)
