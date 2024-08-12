Return-Path: <bpf+bounces-36956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99C94FA41
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39CD1C2229B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DC19A298;
	Mon, 12 Aug 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RxfDjdGS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76316B39A
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505235; cv=none; b=J3dYB2ua92xOoxYghRx9Ok9Di9ECWZlKHbJb5Lz3JTVt42SdWaXzlIhPo9I01PEFosckXZ8E6Va/AQ3AMyv+MGzbldni1kguVD7hh/xyehCitRhmU6oH9zlhd4mACcAH+IDhwKBlEutT92Ane+wX83ty8CUoEP+J1tAm4QMB8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505235; c=relaxed/simple;
	bh=tvqcMueI8bhXuiqM6AK7srDyvkZ4Cq75Q/GFz5bTpX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKt+sc7PyAKXT1a1HguTG6uRj24TWEDEFU5M6+u1bjBlLy42KdVwWYssTBoH0JkOi99HYEiwE/c5I9FbF1pzZLCsBUsqIEpsym54OnTjdeczf+OFeahMc8jZNVGHnOO0vXD9r3sjgbTLz0xxl6r7iROCmIE1DifXJ7j2C803pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RxfDjdGS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso33545645e9.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723505231; x=1724110031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YD7cg+9/vEjihVTfP6GdSKzC4qTymdlhkccRC+5Gbok=;
        b=RxfDjdGSa3K+ujRxXnkcYKnsGfqygd+qRDiQThH1rOyn5mV+71MVllpiaehPL4AMF2
         u1xQ0TPuZ3wr8f5K3y/Cj7GKSTu5w7A8QMvpKwPHLsFEOmsp1oPkCzVa3KehxnMjFJay
         QnwaGMNVzmy5Jzr7P37hJP51gYHJoZNjS84x40pC5P3yLDp7p+MaYhe4EqtS74zSyjOJ
         a/Mkdj/5Y3IHEjeWjQjyTWO9Yv3EnQKTCblQMXLCk6bkYQJT8q7I7P8UdmMsFLJkTgh4
         XmKX7C2ALyQsJv9fjoJRe7eAKaTFva3GWKV5/Jt/pN0D/iO/Eq35BtZO8G8gy4FeAF+k
         4kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505231; x=1724110031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD7cg+9/vEjihVTfP6GdSKzC4qTymdlhkccRC+5Gbok=;
        b=qdWkVuvDqxjgQA61FHNcJm6cWL/18YA5EYLKhtQEc/igYElhlUsSTQuZrNC/i+PPm0
         EAddItixBK6aK4LEKNsBp8T3S9837WLdW9nv3rZcvpISzISpQS41grfGUW1dSn3GCZWT
         MZ9U9P0YSTkFFdeRKO0L+JSjoHc+W4cB6vKZtS8GiRp8V5xVq7khhG4FCL+EG80VqApu
         7cqlx8H5vv2wjWDi+RcgzfVMD02Qaq/AF4NX9BRiBYXSqJ7PV6iRMG9wyIWRuIgWD7jk
         Q0qXu6kj0aqakQ4xlq0BQS3sb0nJoq31KS3/PM7PqiK9lsH4BVC+UKexZ7/Koh7FaiR5
         yZbw==
X-Forwarded-Encrypted: i=1; AJvYcCWJfMq6Xltdbg5N8MroJVukoc0q/s3aomnkejVCQtQo4bL11tPmnL3ZSbHYRgz4PNp3jl5JVmBOt6YWCYgGmgbCTm6p
X-Gm-Message-State: AOJu0YxcsJYGwaWsUUgimA/t+dhQnpEhC3xSoG9qIHny1QBWV/ugzUWD
	hGIjF7+BoHi20BFhM3g5FhEeJ+v6ohplWMUJjrNUxSVkK4c+7+t70HRHbdz4KOc=
X-Google-Smtp-Source: AGHT+IG6CXy2Pt1GGArovitwUEAUTVVp2pZrsNj7gQT7hvcVDqW1OA2/mPl3SeDPLn1DldH7lvDWlA==
X-Received: by 2002:adf:ef42:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-3716e42b973mr806943f8f.17.1723505230255;
        Mon, 12 Aug 2024 16:27:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a99efsm4521191b3a.82.2024.08.12.16.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 16:27:09 -0700 (PDT)
Message-ID: <cd06772c-b4be-4416-9f0f-6d849146ffe0@suse.com>
Date: Tue, 13 Aug 2024 08:57:04 +0930
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: update target inode's ctime on unlink
To: Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/13 02:00, Jeff Layton 写道:
> Unlink changes the link count on the target inode. POSIX mandates that
> the ctime must also change when this occurs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And since we decreased the nlink of the target inode already, updating 
the timestamp will not cause extra COW overhead.

So this won't cause any extra performance penalty.

Thanks,
Qu

> ---
> Found using the nfstest_posix testsuite with knfsd exporting btrfs.
> ---
>   fs/btrfs/inode.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 333b0e8587a2..b1b6564ab68f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4195,6 +4195,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>   
>   	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
>   	inode_inc_iversion(&inode->vfs_inode);
> +	inode_set_ctime_current(&inode->vfs_inode);
>   	inode_inc_iversion(&dir->vfs_inode);
>    	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
>   	ret = btrfs_update_inode(trans, dir);
> 
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240812-btrfs-unlink-77293421e416
> 
> Best regards,

