Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0053B25A6DD
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIBHgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 03:36:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBHgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 03:36:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0827YVaq132581;
        Wed, 2 Sep 2020 07:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CFB5KRGnCokXP3/5VF5fldTn2QYUdtAGHmKSBBsc5x4=;
 b=BiSsXtSg9FJ8LzjrVSjNenJxMeDyRfVDpiCCRSBUvDuHhF5/LFF3bOxKDCP1wnDu/qyo
 hX/cqYFZgYLnwBP3IEAbQrAq/jzjTxWy2mUsOUOjXkvZdiHdFOEzsv+NfjdldnWUMDLh
 HfxbkYw0g9pNisXOQ/LdJac5mF5cNL89Bx2TsUQS3Py26wxj5cMlfPu1BsIItn+mxKWU
 SM2fYUoVsR9jOSdYZv4qE2XnxOHFvknY9RKPq1hVK24/rc3EcxsxP/nHYIj+yDSCxtFS
 0kivzTitdHxy8+aX2i5S8j/9TJ5wdBXaYi1Yu8hzm4dJYyLXLKBjmaTNE3Fltj9Obo60 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eym8rxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 07:36:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0827ZClt153970;
        Wed, 2 Sep 2020 07:36:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kpj24m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 07:36:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0827aRZo021515;
        Wed, 2 Sep 2020 07:36:27 GMT
Received: from [10.191.26.145] (/10.191.26.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 00:36:27 -0700
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <a0a97488-58c7-1f00-c987-d75e1329159c@oracle.com>
 <20200901165333.GD5599@leah-Ubuntu>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <1ff87708-fe8b-215d-637b-5af5acbef6eb@oracle.com>
Date:   Wed, 2 Sep 2020 15:36:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200901165333.GD5599@leah-Ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020069
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/2/20 12:53 AM, Leah Rumancik wrote:
> On Mon, Aug 17, 2020 at 10:18:47PM +0800, Bob Liu wrote:
>> On 8/13/20 12:33 AM, Leah Rumancik wrote:
>>> This program type is intended to help filter and monitor IO requests.
>>>
>>
>> I was also working on similar tasks.
>>
> 
> Thanks for the review Bob. What use cases did you have for your
> implementation?
> 

Similar as "At Google, we use IO filtering to prevent accidental modification of data."
I'm making prototype to turn the old IO-filter way to bpf based so as to get more flexibility.
