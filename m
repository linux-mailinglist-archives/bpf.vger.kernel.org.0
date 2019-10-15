Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E71D8134
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2019 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJOUnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 16:43:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40400 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfJOUnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 16:43:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so10142907pll.7
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFImrjlwDdis+S4o8zdHmAo7m61lA9Pv5l5C8m3KANo=;
        b=OKqm7J59nwIKVshenTUEOr2opHnEfHIAQMJqX8GpBiXLze1N3eR3dDbA5piG/3KkUn
         N051R8BJlarnW22RemwoK4YRFrZ9S/oCmBP69qDmhlXe6piEncMxYSUFG7fxVO3BR985
         MxqfK/uWrPKkbqZ5w080/ogRhpSRX7A7TASE0PclbC3ATrsnm/va9DGA9ZttsWctetzI
         vaigDm22uGGospdxjT3g+5IYWv52yt/DVEyjUItadRgdlt7Pa3Hd3noEytgWPCL3HstX
         BZO7XT0SXQ/BL92orL/yRbEvS0qyqJdUHKH8xdU9fUGPjrD3X+XBspljm0LQkMmrS0f1
         Ufiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFImrjlwDdis+S4o8zdHmAo7m61lA9Pv5l5C8m3KANo=;
        b=ryZNlYfsEj839Y264NUadS041XRX5jB85eT8Z1Q8/2yc3Xr9qnFc63r+LjGe+jH5y/
         NDOV5du7v8k/IgplsAAIf6sbK/0v/ha78gb5uMGqqS1E1y7IpXqytmJhKYbYX23CEnMN
         N6xudQ73lXRIkmMeb+6TJ500QfSy3XO9zo2CD3UOvqdhz2L67qN+rg7DKT+n4tc0pFYR
         HIU9iyeNxCYPd5UWXJQC+XGhzONyiN0l+QX2XUp0il50Kx7ssKYrVWTmB4wiApOTJfHZ
         A0ejlI2GukcOnhid+1Vm6M8MZ/hEc3Dud1wxcaNH5wnyDEarmZI8Jb6gNV2QtevtFjC0
         ixBw==
X-Gm-Message-State: APjAAAUBua1oGdiur2XfdXO4C6insE0C/UR2DleDiqHkOKmF3cPhOrUu
        UQAqyyoG1aPaX5lP6a8upK8F9g==
X-Google-Smtp-Source: APXvYqwv31P0O/zeULkdz7vnyZG3+/tPecj7FQSj+wdMlkN2FrFs3xCy4rQRJvPlh+rnYE7cTzgGDA==
X-Received: by 2002:a17:902:59d7:: with SMTP id d23mr36888998plj.153.1571172195475;
        Tue, 15 Oct 2019 13:43:15 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id y22sm182764pjn.12.2019.10.15.13.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 13:43:14 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:43:13 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] bpf: allow __sk_buff tstamp in
 BPF_PROG_TEST_RUN
Message-ID: <20191015204313.GA1897241@mini-arch>
References: <20191015183125.124413-1-sdf@google.com>
 <20191015203439.ilp7kp63mfruuzpc@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015203439.ilp7kp63mfruuzpc@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/15, Martin Lau wrote:
> On Tue, Oct 15, 2019 at 11:31:24AM -0700, Stanislav Fomichev wrote:
> > It's useful for implementing EDT related tests (set tstamp, run the
> > test, see how the tstamp is changed or observe some other parameter).
> > 
> > Note that bpf_ktime_get_ns() helper is using monotonic clock, so for
> > the BPF programs that compare tstamp against it, tstamp should be
> > derived from clock_gettime(CLOCK_MONOTONIC, ...).
> Please provide a cover letter next time.  It makes ack-all possible.
SG, I'll try to add cover letter in the future if that helps.

If I remember correctly, acked-by to the cover letter was not
showing up in the patchwork and people usually do it for each patch
anyway. That's why I didn't bother to do it for this small change.

> Acked-by: Martin KaFai Lau <kafai@fb.com>
