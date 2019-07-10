Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF063E86
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 02:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGJAFF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 20:05:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34990 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGJAFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 20:05:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so571631qto.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2019 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=uPeAbIsYd3ZLkzVFoORACHLdD/1lc5cCC5md0MnIbmc=;
        b=nB/8LdPx9FgjfI0OR6xCFb/+z6kMQg772mwYuBLQixLmGvFkqeKbigYtsciKERd631
         5N60gm92pI7RSfPAMcOBBP77QWOUQkz1PdPsI420JAeek2w8Hxg3PEaIihg4laMExodY
         k9xCUnYhzsUxaUlbA5qO8gpqsMmFql9Qmsf3BDv3DVeI1zfMzF/STs1wgXMd8ezaWm18
         8bDna0jWrqKQ20THOfiDgAYgtltpgBe3qZXRWd0lxcRNV9lijxC5550dUMfAbD9+rc7T
         OJ/viIKRMOIecFFBJjkN+NJuuRV4IFvIAgq2JWIiUMPM42LKmxGZyxcahSEGm+jxX7as
         qftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uPeAbIsYd3ZLkzVFoORACHLdD/1lc5cCC5md0MnIbmc=;
        b=A6K8ac/iEMSvUayo9KpRGP8bpQwPtyy1SzrIXpvYcZ2B2qX8xL2/IwCrSIP8Tf+PX/
         fOVr6y2avCyvv6TRLpwYuqfBuDLJX5kVDdZXhxBL3jDqlnY5RD1WvfBbOpnf/ZubS1zY
         Rh797841i8CmRkN5nAmuq9LoVXw/Fl/Bz9TZKbdhpDziaLmy5dQmJ5ly3jGW0xq9i/Ix
         hfkuas9KfB/RwXbqno2RpAivBr8CLiJSqqT+zgyy7teUKV9sziCWb+pcePs5/iFL2do9
         v/K9fEbWpwk10JrBJszURXlPcIWsn8EhR/xsRMr54qer5tJq4igJkD5Gdu0ARlUS5rLl
         0JtA==
X-Gm-Message-State: APjAAAWCdHRkc3WK4v62t/7urIOw/+TIZqlE3iKkCpKz3PtWXI9VdEDB
        qmB1+S8X01p4edf/R6V7yjr1LQ==
X-Google-Smtp-Source: APXvYqxc6+NqlnpCXGvxUPhEolicbl9ejPZF6tw0bmJqeHdL4d7lrCFJpvoTJgEGFe5bXp0PEcKSAA==
X-Received: by 2002:ac8:428f:: with SMTP id o15mr20182511qtl.210.1562717104839;
        Tue, 09 Jul 2019 17:05:04 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p59sm162566qtd.75.2019.07.09.17.05.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 17:05:04 -0700 (PDT)
Date:   Tue, 9 Jul 2019 17:04:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 0/6] bpf: sockmap/tls fixes
Message-ID: <20190709170459.387bced6@cakuba.netronome.com>
In-Reply-To: <5d24b55e8b868_3b162ae67af425b43e@john-XPS-13-9370.notmuch>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
        <20190708231318.1a721ce8@cakuba.netronome.com>
        <5d24b55e8b868_3b162ae67af425b43e@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 09 Jul 2019 08:40:14 -0700, John Fastabend wrote:
> Jakub Kicinski wrote:
> > Looks like strparser is not done'd for offload?  
> 
> Right so if rx_conf != TLS_SW then the hardware needs to do
> the strparser functionality.

Can I just take a stab at fixing the HW part?

Can I rebase this onto net-next?  There are a few patches from net
missing in the bpf tree.

