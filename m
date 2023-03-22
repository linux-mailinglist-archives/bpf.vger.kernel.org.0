Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3A6C5957
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 23:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCVWQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 18:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWQh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 18:16:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5B6584
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:16:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so12512938plg.9
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679523395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq68ycejyZvWSJ0XJW70+nJ5/RjbI9lU9v0CQOBtYVo=;
        b=nmFbDxNG4hJlQAwSZlwe0tnBTtLZzKdtoLpdlCJWszBCZ0m6VYjJxYgLQWy6djphYa
         xf+S9JXcrcWMP5d0C2MrIYUC6YX9ZWOquvBGEWfwSbX0kmitojZpfASfDHY4/ju543VY
         0AWRFMDixEqJ69hklUD75zAJ4pWw70dPEqKhKqT+hglonCjzumJYFLwWsxPkk0v5NAjQ
         5n3SvzQiunMLhDDuDcLurTvgnVVcOixHtVRUlLV58m5E2skYz+i0nXqPnu7hEBJl3mOt
         O1xvJTYBkfc6wNjB3711Ai/Z5IDfrRAYPHNL+0g4pwOSyLg4k1Litz6hwxobggK/z56C
         w/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679523395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq68ycejyZvWSJ0XJW70+nJ5/RjbI9lU9v0CQOBtYVo=;
        b=fPE3LKn9nMDFrAl4fZig+1TaOP/Tab/IUj4UK5lcmCqVzKlkAOGSCTzOqmknG+trkf
         6XMzKMrm3OecZQAjgcq+6dj2aBtYmNED1Rdu6ADegviWBe4uvMP+hjBTXrpKNxBwixs4
         OHIp5L95H0kvqqBGpuMAcuSP+H++iHMV+0BMrNvWDZDG4OFSTXOzE12hK5C9gTR2G7pO
         qg1dWGNnki7Jpvq3m0FjRGQOOIJ6tOQ8HcKeqRPiLshQ+xL5mKowE0ndpbehVzxnhxDF
         y81NiJvD3VhpVs8pX2cLXbB9PaL+QLrHx3HJyKsp7EYo0fm39GNWsrkVRQWwGjXaqikj
         lwgQ==
X-Gm-Message-State: AO0yUKUxuSpCDISrqwvXp7U8QgK4cavlMxr7ntE5zKlGqF6udafVYCMw
        OrhgfXVxcLUGsygo68ry31s=
X-Google-Smtp-Source: AK7set9U3OLSaNsbcTMfHj2P6lWlwZmp5GIXepBOi7sf0ZCiF5ox53GDtL3Qty2S0S4zrUElmIJD8Q==
X-Received: by 2002:a17:902:e806:b0:19e:8076:9bd2 with SMTP id u6-20020a170902e80600b0019e80769bd2mr4235693plg.17.1679523395254;
        Wed, 22 Mar 2023 15:16:35 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f4cc])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902b20200b0019f9fd10f62sm1290767plr.70.2023.03.22.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:16:34 -0700 (PDT)
Date:   Wed, 22 Mar 2023 15:16:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org, kernel-team@meta.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: return long from bpf_map_ops funcs
Message-ID: <20230322221632.ekzg3htepzvbrfdy@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230322194754.185781-1-inwardvessel@gmail.com>
 <20230322194754.185781-3-inwardvessel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322194754.185781-3-inwardvessel@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 12:47:54PM -0700, JP Kobryn wrote:
> This patch changes the return types of bpf_map_ops functions to long, where
> previously int was returned. Using long allows for bpf programs to maintain
> the sign bit in the absence of sign extension during situations where
> inlined bpf helper funcs make calls to the bpf_map_ops funcs and a negative
> error is returned.
> 
> The definitions of the helper funcs are generated from comments in the bpf
> uapi header at `include/uapi/linux/bpf.h`. The return type of these
> helpers was previously changed from int to long in commit bdb7b79b4ce8. For
> any case where one of the map helpers call the bpf_map_ops funcs that are
> still returning 32-bit int, a compiler might not include sign extension
> instructions to properly convert the 32-bit negative value a 64-bit
> negative value.
> 
> For example:
> bpf assembly excerpt of an inlined helper calling a kernel function and
> checking for a specific error:
> 
> ; err = bpf_map_update_elem(&mymap, &key, &val, BPF_NOEXIST);
>   ...
>   46:	call   0xffffffffe103291c	; htab_map_update_elem
> ; if (err && err != -EEXIST) {
>   4b:	cmp    $0xffffffffffffffef,%rax ; cmp -EEXIST,%rax
> 
> kernel function assembly excerpt of return value from
> `htab_map_update_elem` returning 32-bit int:
> 
> movl $0xffffffef, %r9d
> ...
> movl %r9d, %eax
> 
> ...results in the comparison:
> cmp $0xffffffffffffffef, $0x00000000ffffffef
> 
> Fixes: bdb7b79b4ce8 (bpf: Switch most helper return values from 32-bit int
> to 64-bit long)

please don't break Fixes tag into multiple lines.
Also keep "".
I fixed it this time while applying.
