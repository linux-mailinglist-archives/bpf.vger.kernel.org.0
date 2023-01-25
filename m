Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7C67BA0B
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjAYS74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjAYS7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:59:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0BE23C55
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:59:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFPx9P029536;
        Wed, 25 Jan 2023 18:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ow1/pLFYPxbT2RmTt/odC+6tNrxmDZc0s9U4jZb9gwA=;
 b=acZz729P1P/UrA8jibozeTJ8uSYZKpSD2jAHpAUKyhZj/rwomznaw8grq/O9SPvbRMWi
 Jhks+tajQfI4L1A5ikrRYWLb+LY4+kaeNrYQDp/hrVHSO1Ti2Y3zpPUHUht0i9l0z+SC
 DZzRS0ti0i7rUNfbhQaiw60s/EoIHJi/+B0u7lRLM8H+zoFYLosxSbVSD6UyXbqU20Pe
 P4ww1j34aKu8YVT7jd063iNN0EZ/zagRHeC5IvUrZzoEW2wNsjL+swlCmMTDgOjyZZQv
 ru9FuUQt9Dp4po5hIF5pmnCCM2wxs2GH6MwoT+Tq6YUVBZZJ9pI5QD4s8xrYIHI5fKQn YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n10uy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 18:59:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PHeekj024985;
        Wed, 25 Jan 2023 18:59:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gdtnsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 18:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPgD4jEOAXsHo8t9vXeiSndW/Hwp2/lWLjl2m99a9U9Wh5yI0cTe2giF9tXC35iBrOmzZnjJh6HEYCljVAzzDcGJqA1b6CkaNIJl/gbj/c+fECdZgDB+YF8xQ+XR8g8BJXINof89bEd5O/i10Q4doaG8kp7fCStxKy6q+5Sv9wU0gVzA6DRV2n9GDwiNid3mXPXisPCiISt0rjgzm9MP1da3gEdMJ5JOqaIdnFILjnD/jHxkMpaOWE3jrH1hGhsCacR8U7R3RrPi0gKvSsKbvfgJbLGBQux57UYmSRvsdjmEsFvAqtGeZlK+/xRUrWq0VmfrgxaLD/jZcgN+PyXO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow1/pLFYPxbT2RmTt/odC+6tNrxmDZc0s9U4jZb9gwA=;
 b=OeFJ2IRqF7IQHo2TjPKxEWVsjILQPvOzbP5rO+MX43Bd6uujcx1BT2BiuYgF2cbNe1tRWigDT+82+iis7iClLf5IOagI8lJr0MWPHetnmir9+sYMnu0vNJ1NdjsP7k4kUJwZ33fsOL1A5AD8r8yTgWz1p7H1VMimRHD8IwF8JUm6sldNV8H6zKcftWwSigjOwtV5ecZqsLMcqUNocey0ZTO279GOELTYkBGoGbU0tUljSivoj8HHywpvE6tGLAG8K20KhOMghYNEWyVW1mQUme3SZVnjomPtkwrpwpLsX1LyBbELDKwiF22dOVUwAmsOJUmSd5wffpGlO4l9OBC0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow1/pLFYPxbT2RmTt/odC+6tNrxmDZc0s9U4jZb9gwA=;
 b=TuKkxUNDf3hzXxGqOfGJ5df3qxNIxy+XyMoBgs/Q/iYPJZqsL1yjh23Y1AnyVsCMjPdhQ1jdIbuweHxuVRvhrREEysl8fZgSxKDl8bJiJpZp9aJLt8BnCzlcDh2/7LBrRiRNgSGkJM1NN+ahAr/hr3mggX+uqS+RKmqZnMbPbi8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4143.namprd10.prod.outlook.com (2603:10b6:208:1dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 18:59:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%5]) with mapi id 15.20.6043.020; Wed, 25 Jan 2023
 18:59:23 +0000
Subject: Re: [PATCH dwarves 4/5] btf_encoder: represent "."-suffixed optimized
 functions (".isra.0") in BTF
To:     Kui-Feng Lee <sinquersw@gmail.com>, acme@kernel.org, yhs@fb.com,
        ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-5-git-send-email-alan.maguire@oracle.com>
 <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <e719fbaf-9387-7818-c9dd-7deb545eb60e@oracle.com>
Date:   Wed, 25 Jan 2023 18:59:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <8b915c70-8ed4-9431-cd19-7e3194d29c09@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: c117d202-48fc-46fc-4eb9-08daff064589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkOxEIAi6FJvSgPIbq/judgab4yhASSCGE/P+BNcM2AIvASe3tdqGqmRFwX0I9iApU2I97AdjgesFCnKpAUXeR2C/2Sg4s47hCRSgxJBTfN+sFfuZ250G7SD1GOfHvYOwJZwD7PzfuaDgtn2mrq6LrUpQis9r08InTEAwootdLYDNLFgkSsERbxY0WVJJ6dyoJo4Xq+pwlDshFdzGxjQUMeyzNOu2BxCb8FncyPW7nNYyCaaireXEz+skhOAzuptzL3we2VtHmD1nokR2KF3jQgY+xXx+Fb4luCUGJZX2MO+1HGU/aHWwjmth8Mz3POXMovsiinHt3iQmkHgqv9QMjyyxIZun56neFlO9hxNC3nMRWoR4dhfCd6UfOskndOi8x+72HFhxcRGbwRQ7xtT3unhKPd2tWoxFjYuAB74f7saaIQdV/XrVJLOnRKpPU1/w8lv9sPSwlUbNeK6jukLv5gogeF/Y8n5De1MYsce+ULmV72gKGw9FgyBhtD3JFsS69C8OElN/4ngKFGGX0Tu3pngLc96T8jWWH+0WtvZ30SEoH8PnVp5VFmoKaCmjwYsDU+V3ngKvhEa7U4iOUF+IBHHU/MTtf6XSLd1xO+VWyUnOpIFZKHsohiA7S7xSeGDlfPo6rWDqPBXM77NSfabqSShP6thzBj9a36mxJi5VEyZXLqSe3hOtiw04DNG6HOppzxDxMP+cgWvkZwAB0hFuFwzuPPX7Lnu3oBk0lSGTA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199018)(2616005)(186003)(6512007)(53546011)(6506007)(6486002)(478600001)(316002)(66556008)(66946007)(31686004)(66476007)(6666004)(5660300002)(83380400001)(8676002)(4326008)(41300700001)(7416002)(8936002)(44832011)(2906002)(31696002)(38100700002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFZTkV1aFBUay9rdXBFblA4bERGNFF1SDdOaEI1M3QzNytsM1RCdEtoaEts?=
 =?utf-8?B?T0lDNE50WGVNTTNQZUZjUGNSYnRrYnU0cUxRSnhiWW1QTHllWVdpSW9GdFlo?=
 =?utf-8?B?cWJQNDhoWWlkZm10a2FaTHZsUFFrYmdtRDZ2aExUOUppblg4UWpUdjJJbTBV?=
 =?utf-8?B?d1dJdks0c2lkdHJ6Ylp6QzhQSklKQkFSZVJxYWxjYXdsVy81M1BIcm0rYzhq?=
 =?utf-8?B?am5WenJHdWJMS25zbERzZlVLcFUvdjZ6MVBCQnRFUnM0V01YSzhNL1ZuYm1B?=
 =?utf-8?B?VXpPend0SHlhMGFkOUoyb05IdWR0aXJadWozRTFDVkxmU1J1SHBXRWhwL3di?=
 =?utf-8?B?VWhoYzBjakc1YldFdUxaTHJ5UlpVVVFZak9WOHdWRUpValQyaHY4SjR6RmlJ?=
 =?utf-8?B?SCs5dDdvaFhvY2U3ZUd6Nm8weG9Vb1poK3hZcVlZV0J3ZUh1WVRvK0xzVFA2?=
 =?utf-8?B?d2VJRjM3eGp0UHEyYjhMWWpvckwyQU9TSFVVdnNjMDM5QkpmU2JCRnl3NXV5?=
 =?utf-8?B?enc4SUk5cFpQMXRQN3ByZnp2SnBITXRWaGxFRzdZbm1vcUpEeW04dy9GYWZm?=
 =?utf-8?B?WE1jRUlyUERQNXhSYVhPMkd1MEJ4Z2xtLzJNNFB4TG93Z1RjM0J6M1o0ZlBk?=
 =?utf-8?B?eU5kR2VlZ2JKS1VRWVhoZEYzS2Z1M0d2ajhwK1RuQmhLWThUanpqM3NZNk5r?=
 =?utf-8?B?VE5xc28wVmp1R3NmYWtjRHBQV09GYWI3cWpQb0tOejFLTURNOWk2ZEZDd3ZS?=
 =?utf-8?B?aFVlRXFMWnZRVi9uZUNUbEVvVGVOWHdUSFYxNFF1Mm9uaWRjYVNlV0VjbzlZ?=
 =?utf-8?B?RWJ4enNWR2lMVGVVRzBNUUxnYWxRYTBnaDZ5anFTenpmdlNCajFmbXh2QkdT?=
 =?utf-8?B?RVR6NjZvbW5ycGZKejBQVVB5YSs5djJ0bDcycjRaOEZQcFprS3FEMDBLUnhk?=
 =?utf-8?B?NHptY1ZUdTFXbEdtTzNLY1E1cmdveVdKOFBRNlVIa3hkL1VQSUtEU2R5c2dn?=
 =?utf-8?B?a2w4Ti8xc202T1Z3djhoa0hWcU41dWZjelB5Qm9NSzA2Uy9PbkxtTVVPZnFk?=
 =?utf-8?B?UW1JRnNydnJ3SUoyeUJ3cmYva1I1UmdyZ0hHREQ1RDM3ZlZKU3pnUUhLeXlZ?=
 =?utf-8?B?dnBPa0hDT3ZaUGltSE1FTEhuN2dWL0VldzNHc2crSUNUYTBHTUtadVJhNTA1?=
 =?utf-8?B?YS8xaytwZElLZVpSQURKRENDQjJDTTNvcG0wcFl3blo1MnZVcGlHNkxJTmlV?=
 =?utf-8?B?a2JFZWtRWkI3Mjd6QTkxSXBSaGhTNmJkL3VvT0Nucm10Rjl0UGt4cHRyTGR6?=
 =?utf-8?B?VUozZkRIcmYrclpQbmlZWjVNSHlFVWtXM1FDNHNlcHJjMmdRZHpFc09SWjJP?=
 =?utf-8?B?cTFhdWxJenl4djNTMFFTTjJ3THBUdWxHeGNoamo5Nk1Db2t4M3d6ZTFrc1dz?=
 =?utf-8?B?cW1EM29HZk1MYUxsdStYQ216VzJtakcyZGdOOWNLMkZGUVNXc3FWYUM1dndP?=
 =?utf-8?B?dDNpS0tzdElteW5SZnlWSWdqdndXbngwTEZ0MkRqanVUUGtIZUNxWFNsSVlX?=
 =?utf-8?B?RzJvZFJ1bVBmT2h5THhTMXF1cFcrNWdhKzVxRExrY0Y1bXY0c3JZcnZyVUZB?=
 =?utf-8?B?TW4yT0kzbDF0eTRPd3dOaTN1am9Ic0VpSWc0SVdtblAzbzA5VFlxR0JlNitZ?=
 =?utf-8?B?bXVTdHZheTdHM2tncWs0dzhPL3VkODBDTUo0azFiSXJwWHBxR2hPbnJrVGdK?=
 =?utf-8?B?ditITjQxWHY3Vy8wb1h1N0pmRE5tOEFXcU8vNFhVbHJRL2o2dU9mMGZtS2U3?=
 =?utf-8?B?UVdGVkNsbnZyVGZDeE9Tb3FpeklTR0tmT1Q2cERFMmdMZS9XaVhjcy9yTmV5?=
 =?utf-8?B?OTlGRDc2YWQvcjR4V3B6OEtmUjE4djhJR1k5QS9HTW9YdUwyQTI5V2ZXN0RL?=
 =?utf-8?B?SUV2MkVnKzN6QVBabGFuTi9JeDM1aXFiOXl5cms2dnphMGZVVGh5SE1VKysw?=
 =?utf-8?B?VHVIYWd6V1Z0ek0zZXlFVm16TVgzeHl6SWIySVluZVVtVzZJdHdxcGJaaGtF?=
 =?utf-8?B?a2x0bDFBemx4NmNKcVcvNFo5R0IrNlVlMnRHVTc3Zjlrdk8xclc4NFRWeGY3?=
 =?utf-8?B?RGJEckptOW5LWWthbHZTUzFORmpocnZFVDVRaVJZN1lrcjIrenJQd0VsWjgw?=
 =?utf-8?Q?rEBeZQgL9i6sTQPY4jbWsIk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QXYxbHlIZFhFYUJDaXNVVlE3Uk1VcjBGOFVQcThvOWtIUDdPSytPYVYwR1FH?=
 =?utf-8?B?NlBHTk5jZXo4THdnQk13NVpCektQN2FiUlRYTDFTbFM5V0V6UHc0QzduaEgv?=
 =?utf-8?B?Z0NNNUswOTZFRXlpQzFpbXRweFJKWVZYRksrdnE2Tmozc0h1bXJkYzJ6bHRh?=
 =?utf-8?B?N1ZZSGxITEJWWU43RERpQ1VWK0Z5Unhua0RTZHlieG5ESGdKMVFCeDdPYUtC?=
 =?utf-8?B?VjVsSkZlWUVoc1JPWEJrZ0cwUDJOV3VNSFg2VnA4Z3h0cUd1ckdFQ1hOSGNp?=
 =?utf-8?B?TFVtUzRrRXFsQTJnZXl0UXNkUTlORHQ2WDRDMWpHeU54OXNnem1QQm5oMEtH?=
 =?utf-8?B?RndlWjZOM1lXeTlWZ3A0TmRuaDJqSEsvUkZDRDhrSldOTFFYNFdTYUdYM0F5?=
 =?utf-8?B?QlZNRCtlbERMS014dlV5dERDZlZuZVFXUlF3RHlvRUNPT24vbjVIbVpNR09J?=
 =?utf-8?B?TkJOM3V0S2Q3VTAvaW9PVlVJYTZLVU9wVG00eUVRMUtiVUZBQVNHd3JCYWI3?=
 =?utf-8?B?bjhyYkc0Nkp5RzcvbHJ6ME1hZkExdk5YYWFsa3ZjTzQzOGd5b09ueUJNa2pu?=
 =?utf-8?B?OFIvNEdiSEpJbHVkbi9WbVlGNzV5dG4yRnZ3NTQvdElwdG84YXphYW1LNkhX?=
 =?utf-8?B?UFJpTGZXVVhDQWxMcDRzMGhScGRiUnhxZjh5Q0xOeW43K1JidWk0YkltN0hi?=
 =?utf-8?B?M0hsWHlpelVBOVlacW1DVXMxanp5MG8zZWdiV1h5Q2xic2RzOVBmT2MyTHpm?=
 =?utf-8?B?akpHZWVXbm9CVUY3L3JFU2pGODB1c0dNTjlQQThFZ00xeURCb1lKeUFlY2wv?=
 =?utf-8?B?RlZ3dC9VbmhMUDc5VXRDejlYdWRyS0p1S1Y4YXQ4aXNxUEdlenBHa1lSajgr?=
 =?utf-8?B?SlBTSUkxck9wUWp1QXU4U0o4anR3OUNOemh6ak9Sa0JTbWg1LzIxaXU5cjFw?=
 =?utf-8?B?bFJKOVJGQ0FJemorRkRuVjlxdkd2NXhsVXM2cGl1R0U0cEFUS3ZCL3puYis5?=
 =?utf-8?B?dHI0Rjkya1RBRld5SkFsYklNZ1gzQU8vZWE5RGVyQmtjMHUvTE9XN3d0S0RJ?=
 =?utf-8?B?L3E2L2srQXkwNWVJaXJVOUh5aWxDWkZHL2EwQllJZHg5SDZzSFliak1HSHRl?=
 =?utf-8?B?dUJ1bVlYdXQrZXFKdGhBWnVZbzdCOUJDMHpWSVlIeFc0MkdEcVpGejVqb3BL?=
 =?utf-8?B?TjdEU0FxMXB3T0d4U0U5Tnd6dW8zaEZ0dWJ0UjNOMFpSZVdaTkRsbXpUbFZu?=
 =?utf-8?B?a0l1V2NMaGcrS1g5bHB1ODczREZpVCtJK2ZpNWpUNnVSR3VKdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c117d202-48fc-46fc-4eb9-08daff064589
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:59:23.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I6ltKmy2voUtmRuE8jR9+Tfvg59iVC9fQrZYHX59afF49INBWyIuOmQLqxtMg6loKNqT7BJmyM8CqKWx8V1xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250168
X-Proofpoint-GUID: zDV8-Wnmfqx34T7vUB69tyuGQ87YVgXr
X-Proofpoint-ORIG-GUID: zDV8-Wnmfqx34T7vUB69tyuGQ87YVgXr
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/01/2023 17:54, Kui-Feng Lee wrote:
> 
> On 1/24/23 05:45, Alan Maguire wrote:
>> +/*
>> + * static functions with suffixes are not added yet - we need to
>> + * observe across all CUs to see if the static function has
>> + * optimized parameters in any CU, since in such a case it should
>> + * not be included in the final BTF.  NF_HOOK.constprop.0() is
>> + * a case in point - it has optimized-out parameters in some CUs
>> + * but not others.  In order to have consistency (since we do not
>> + * know which instance the BTF-specified function signature will
>> + * apply to), we simply skip adding functions which have optimized
>> + * out parameters anywhere.
>> + */
>> +static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
>> +{
>> +    struct btf_encoder *parent = encoder->parent ? encoder->parent : encoder;
>> +    const char *name = function__name(fn);
>> +    struct function **nodep;
>> +    int ret = 0;
>> +
>> +    pthread_mutex_lock(&parent->saved_func_lock);
> 
> Do you have the number of static functions with suffices?
> 

There are a few thousand, and around 25000 static functions
overall ("."-suffixed are all static) that will participate in
the tree representations (see patch 5).  This equates to roughly 
half of the vmlinux BTF functions.

> If the number of static functions with suffices is high, the contention of the lock would be an issue.
> 
> Is it possible to keep a local pool of static functions with suffices? The pool will be combined with its parent either at the completion of a CU, before ending the thread or when merging into the main thread.
>

It's possible alright. I'll try to lay out the possibilities so we
can figure out the best way forward.

Option 1: global tree of static functions, created during DWARF loading

Pro: Quick addition/lookup, we can flag optimizations or inconsistent prototypes as
we encounter them.
Con: Lock contention between encoder threads.

Option 2: store static functions in a per-encoder tree, traverse them all
prior to BTF merging to eliminate unwanted functions

Pro: limits contention.
Con: for each static function in each encoder, we need to look it up in all other
encoder trees. In option 1 we paid that price as the function was added, here
we pay it later on prior to merging. So processing here is 
O(number_functions * num_encoders). There may be a cleverer way to handle
this but I can't see it right now.

There may be other approaches to this of course, but these were the two I
could come up with. What do you think?

Alan

> 
>> +    nodep = tsearch(fn, &parent->saved_func_tree, function__compare);
>> +    if (nodep == NULL) {
>> +        fprintf(stderr, "error: out of memory adding local function '%s'\n",
>> +            name);
>> +        ret = -1;
>> +        goto out;
>> +    }
>> +    /* If we find an existing entry, we want to merge observations
>> +     * across both functions, checking that the "seen optimized-out
>> +     * parameters" status is reflected in our tree entry.
>> +     * If the entry is new, record encoder state required
>> +     * to add the local function later (encoder + type_id_off)
>> +     * such that we can add the function later.
>> +     */
>> +    if (*nodep != fn) {
>> +        (*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
>> +    } else {
>> +        struct btf_encoder_state *state = zalloc(sizeof(*state));
>> +
>> +        if (state == NULL) {
>> +            fprintf(stderr, "error: out of memory adding local function '%s'\n",
>> +                name);
>> +            ret = -1;
>> +            goto out;
>> +        }
>> +        state->encoder = encoder;
>> +        state->type_id_off = encoder->type_id_off;
>> +        fn->priv = state;
>> +        encoder->saved_func_cnt++;
>> +        if (encoder->verbose)
>> +            printf("added local function '%s'%s\n", name,
>> +                   fn->proto.optimized_parms ?
>> +                   ", optimized-out params" : "");
>> +    }
>> +out:
>> +    pthread_mutex_unlock(&parent->saved_func_lock);
>> +    return ret;
>> +}
>> +
