Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6D18525C
	for <lists+bpf@lfdr.de>; Sat, 14 Mar 2020 00:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCMXcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 19:32:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46013 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMXcI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Mar 2020 19:32:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id b22so5030515pls.12
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=agD80IGlYj8IMCSIF7aU3TEJwAM4zUDXExuUEORYIVw=;
        b=gZSrxHl6RRDak9zD5JEa9NA6I5VpqJzLw0axqEPmykTABmcmczocfVDWdQqnEzyOg8
         FARf1o2pM91nKtbV/lMqoFVkYoVXM2rE4NNizdHGXi+kjGbKK0+5dirjMSWdZ/dfNsOE
         FQXxOGeslMxH0AYlDLQC9rWNgQtkE9JhaeFLVLAinnzoMFRg5TjSWSN4wwQ/cvNPseP+
         gU4O0FsghiD7Yzr23MY/EihE9imwRMuBeRhZLdRGwcTwMlMDNlyXWFmSxQFG9FVB8/pg
         3OB6Pj9rdATZbrxy5YovgvNJfGvWMYxuEvLP5P7zDsTkRlbh+liUVYXdnxjkkPfNmntw
         FMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=agD80IGlYj8IMCSIF7aU3TEJwAM4zUDXExuUEORYIVw=;
        b=IaapBNglduhRqjJOg/Fex6uIbSmOhXCUyA4D0UFgUXJArHRZEbEoCAwmbk+wYugZlK
         /jrwKQqYpXNHKS7rh3ZE/zxy9zar6v+5sEDBBzdq5FoHyt8YJq33Ra7BTjaXIEa8DY+5
         ZC+bXXXkyQCNVulzOsksZIet5S2rp33QXSjYAmwE2zr8oA/jY7nVz3/UecMKLrBx9jzO
         SGUigX3UWcjkmNGg9aIG9wa+D5USOc0t3JHXBq0PnhKetDvKP5yFUzV5F9dYi7WSKt/s
         WBupOta0wzQIgBNIqCmnTbA3XsVaN3v3rXKX6PCtegJdMH1o4GVO8y/s1HhKohjaJuA6
         ffPw==
X-Gm-Message-State: ANhLgQ3fmvzLT8ir4vHpXw8Go8ZBGmGBZ6xHXIR6eHJO66YOJiUBerIf
        IsoqqRUBVwzHC2JZ7orZaKeiXQ==
X-Google-Smtp-Source: ADFU+vsHAL8O8/cQ2tYFfxqA0bpyzW2uKBLeMm3bsBpAoMvBIj30OdbyYwi+43W8T6wQmnUGkzE7wg==
X-Received: by 2002:a17:90b:151:: with SMTP id em17mr11858305pjb.51.1584142327376;
        Fri, 13 Mar 2020 16:32:07 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id r14sm3195159pjj.48.2020.03.13.16.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:32:06 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:32:06 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix spurious failures in
 accept due to EAGAIN
Message-ID: <20200313233206.GB2179110@mini-arch.hsd1.ca.comcast.net>
References: <20200313161049.677700-1-jakub@cloudflare.com>
 <CAEf4Bza493cXh+ffS7KHtgGnVDYwyxwDXQ_G6Ps1Bfm4WVRLQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza493cXh+ffS7KHtgGnVDYwyxwDXQ_G6Ps1Bfm4WVRLQA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/13, Andrii Nakryiko wrote:
> On Fri, Mar 13, 2020 at 9:10 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Stanislav, would you get a chance to do something similar for tcp_rtt
> as well? Seems like all the tests dealing with sockets might use this
> approach?
Ack, will take a look ty!
