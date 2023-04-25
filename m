Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56D6EE5DC
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjDYQgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjDYQgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 12:36:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14254CC17;
        Tue, 25 Apr 2023 09:36:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFx8jH019790;
        Tue, 25 Apr 2023 16:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OwY9kkWfCy4hy1StlNycC+bdFaUb6gHgCvro1NOdnEY=;
 b=V+ZXOZL1a32yQ3Y6k5y/Pu/euL1MvpJt+P8NyNx6ZvLdcl+/rV/dWszDkGW8O29eWZbx
 kzH2WIyWjDT/pCD4Is7pS61QjvX8Z6VeISm6xu5e0njYOO5fKPngCBct0uBYbPgiY7Mt
 KFsXg1hQPT4QJST4AJ9DlttfuYpBB5DUwWb8GRcgY3y1TctKu+hnwecg/1yuAWefAH9U
 LebCSd1pYcMvvXtPxGTkGDh8sUKpt+pOtAmZsytQqAa1kj7Je2mQE/2IOT6r9GYa+U9y
 SK/an3X8Da5wahMlVsGgJHBOMNADL0uXf6CcnZ4+06GDxgpwTduc+2EFZKxOnP5eYSZs 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcx6vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:35:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PFOniI013428;
        Tue, 25 Apr 2023 16:35:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616f2pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 16:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt6EPMK9OC717exTb5LFTGvUZh3q4yvRgYqRywICqrv6s1ccdx7M5ok55NqgyUSFXst30mgC74VddcN92G4GFD4sO9V8sUcpIQdhqJQrOWq/qjZ2dRybRJD0TLMkRuxf+g2AtD17UeS5hoKevcLsKvwW+/Nwc9H7P58lBOCWT8esMLm7+rc+yfIDeuG3oi9th3+2zNVptAi/CUD/0eTJcr1/pHyl+7NYIMZF1BmbzKBRNFNg95QuH1MEHC8k/qxPFjgGYb9FpVGI+CbH90ZfqrV8E3xPPD4GK+HJB7Edx2fACMHjxZ5Vv4PCP9ORVRp037Ly8V2TKgZHoVITkh5bpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwY9kkWfCy4hy1StlNycC+bdFaUb6gHgCvro1NOdnEY=;
 b=IOCZM5BtCADPmflHfB8bM9wSUMiZ+VPUgi9lFF+9f9bX+pWqRYI7Ska02zvm19SDDBOOkjs4w8LLcpAiao4FyZndSFLpimPQTAsxcq4Vlj6fai2CnnGoD/DR4wEp6+APzXjSIRUm9fVXKZpRKafXER1J64EzQKyPjh6rREBn2ZjRtXQFgpGi9PRe95nUh8wKrkvHkZCDaU0DMHuXQiaFr5mgUUEhcNv4Fq6Gm40ScBtdWT1wycZTtCvdFK+ysyP1K679NcaTrTYMBTg3+tp2ltDfhepdWTvkuF1gaH4v17pgtF8jfx9h7XocMB+Vsmrrq84sH6k+i9iDzY8ekVtjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwY9kkWfCy4hy1StlNycC+bdFaUb6gHgCvro1NOdnEY=;
 b=mLL2EfFHPpDi+EnCek1Lf+fpR+pFT6VZ3GNbHEOeiBz5ohmbPyNnvYiugudzdEBAGz4Yct8CcWEUVmuWVoDB9NcfeObhDwTqYHrLpn/1F+eDLI42rvGsYr+ieL2LqUnwaFGKfcf35omRLdkzUkvG5j/aoF3OUtuuR3y6eniNIzU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB7108.namprd10.prod.outlook.com (2603:10b6:510:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:35:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 16:35:41 +0000
Subject: Re: [PATCH v6 06/10] tracing/probes: Support function parameters if
 BTF is available
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
References: <168234755610.2210510.12133559313738141202.stgit@mhiramat.roam.corp.google.com>
 <168234761528.2210510.7129186956547286829.stgit@mhiramat.roam.corp.google.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <d75c3720-29f5-5e83-f5dc-cbdde75a4e82@oracle.com>
Date:   Tue, 25 Apr 2023 17:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <168234761528.2210510.7129186956547286829.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f0a9f0-da1c-4cad-12ba-08db45ab1bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1R/6pZcj4/TQMwv7/4La9XPlyy8NJtzTIapyZM/R9KfUzTjG/+rNUsTtSA+lvoDKPGITyIgwC4X+LRGi7i+dfYkX2G6yteRprMClH4n7Js/PcPjn69QNjejcFI7vvKtravzzPU9EmZZvL8mn2rHIn8ZR4AKZP3nqA0YPlDpNo+aU1CkYbhATEaklp66/WO76M/IFV2pxDSzu2UW0V3bAJazgLtJmZICQaDXX/bPvHDwwJRq+iZSoj/auR6JxRlpHWUWkw3SZQpmavaEyT/x/ETn/8urWLqoFBAhOvxiO5eQ/Tj64llY81Yzyuilh4gGuXGRrNsaZHDc6BNscd/ThuCwImVFE4SuKHsHuX0geFWKfqs98lX8J33UdVidt1H6OpX1EgZGcVDst+3h2Rjdopoq86LZqOmLNAd1j1wkUvPcx0IZ0FQt9jo53HzJPaGmIAkdcHiFapqmZ5pHZw8F9vVx2ifrZdzvNRzzn9cNiRlsozj73+N64sIbyCldoD5Zowx0ISa/3E+jwxCC2NNq8Zjbh0J7PQV66HuU48U0y8EdfmSZ0sjzXuUTWqqlS2CuM6k+HMOjMPMO0sxI5uJaH/GziEJfGMKKWKspvYnyzNSSYDtj2zk2Zyf2HvbyRgbPOwt3tIJqVk9GqrydvOYYxAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(31686004)(186003)(2906002)(30864003)(36756003)(2616005)(54906003)(41300700001)(6512007)(6506007)(53546011)(31696002)(44832011)(83380400001)(86362001)(7416002)(6486002)(6666004)(8676002)(8936002)(5660300002)(316002)(478600001)(38100700002)(4326008)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3hDbmZnTXJteUpuN2RPUnFucGM2UXlqcXg0ekUzcWFtRWJta3BYMUNnUUlT?=
 =?utf-8?B?RjVBQ2V6NDN1cFRnY2E0bFEyeHBHY2dFRXhyMWVkLytOaWtwNDBFUnFXczdm?=
 =?utf-8?B?bXRJODBaa01kTU1zWEg2Y3hyN1hqVkVSMUpCY3hmNEdyQWVnTkxJTVUwUldY?=
 =?utf-8?B?dmdZVVBmdlZBdU5wK3NPN2VLSEUxa1FJSGR3TTYyZnJ6aENyRHJ6Ukg2YSsx?=
 =?utf-8?B?SW9PNTh0N2FBRXpLUnVhK0JXaFVITUFFSGZGWEhHYVdBL0F1ZzdXK01GQmky?=
 =?utf-8?B?M055RmJubUxKbnFuQUNHa2N3aUJRdktJWnNtV3laZEwwd1hrS25xeDBabndF?=
 =?utf-8?B?c0F3aDB3cnRhclVjWXhFcVlkUDhsR1Zmd0hjRE15SXRKTDVNYTZ3S2pXaFlK?=
 =?utf-8?B?emYzSDV0UUZBN0J6RHVua3pEdnlKNEJyZi8wWmxmNkpGOFdFeGJPZEJYdGha?=
 =?utf-8?B?ZHE3ZUd1NVgrcTJrU2NYNGxOQjdReTVtcjVFdWdySUFtcEZzTFF6cDExeE1t?=
 =?utf-8?B?WGNzRkJpVDBYdi8yQ1RQYnBJZWZ4N0VKNzdqVjBDVGVuSDIzNW9wR0lIWkdm?=
 =?utf-8?B?WnZiVzA3aUlWb2VaMnBjd3FmMjdNTlh6NVFlRlJQQjE1UkFOQ1pmWElMRHVi?=
 =?utf-8?B?dUl4bFM2c3ExV1JCdy9QOEZzWVNxR0MwY3p0eHJpN1drTWdpbHpCMkF2c2JQ?=
 =?utf-8?B?WmhoWHpENUhsVW9HOW43Vi9GMDVrM05DODg0ekpZMjNZNXIrYlpnTmQ4QnpV?=
 =?utf-8?B?VXhMbW02Zlp0cGYrZURFdFRlYjhLZ1p1cm5aazZhWWQrbXFDQ2xqOWw2NCtM?=
 =?utf-8?B?RzREMVVxRWFqYklCV0NFc01lR2c0STlLUmtnUmdkSmNCVXQ1OHplTG80YTFT?=
 =?utf-8?B?MllDd1o0WkpWWXdiU0xDaTdnNjFrdEpFMDZ4d1VKS2wvRWdCWEE0elltMmN3?=
 =?utf-8?B?aWlZbTZZTEJNOGVjSFgyUGtWcFVpaXVkOFFCNW5WR3U4WDNjWGVTejh2Tkwy?=
 =?utf-8?B?Nkc1UDVzMkJ4NHRseEFiaHZyenp4UFpSMU0wdXVLSUJWQlNVQXlDOEdXbGIw?=
 =?utf-8?B?dldNRldhRkVTK0crZCt2WWlHSCtReDJETFJSb3h5aWFXYkU5ZTZWeHFKUUlQ?=
 =?utf-8?B?M2NTK0c4SjVKOUR3MlduZjB6MldKR0JaOTg1eXZWYlkvZGRUbExReTlTMllJ?=
 =?utf-8?B?NU5qaTlyVzd5dlhkbHpXa0MxMjhyZVBvc1ZrVExjY0NzSTZPazRVRkFYalhp?=
 =?utf-8?B?REVlTnMyT1AwQ1JkWWhsdHV6Mm5ESEl0Nm1raDl2Z0NCUVdFaTZZK1UrR0JJ?=
 =?utf-8?B?V0kwUU9DdE4ycGFhdjNCMWFsVE1OOTY4T1RHYjBpQytERzFFeWwvRFFVVHVO?=
 =?utf-8?B?TjRvaVFxWkpmZkFxUXVwU0pQVW9xTHlIZG9aVExqdXliOWlaelhPR28xOGpX?=
 =?utf-8?B?MGhVTlpiazhleXkvWnpzM2xzM3R0TmM2bnJjTHZ2SXM0ZFJyemhRREdtRmdB?=
 =?utf-8?B?OTdOck9tN25sQjVuaEdDYlZ5T0tLWTVkd01zWDJPL29VbnFyV1hjaEZrNklM?=
 =?utf-8?B?OUlSemp1d2wyMHUzY3FXcU44SFhZSTdjQS90dERDZEVkWlFkdWFuR245MWVS?=
 =?utf-8?B?WFBDZjkwckVHOGtBOWRSbWxkZ3Nlck9WQndSOU5zeU5RdWVJWDVpbVZIblBu?=
 =?utf-8?B?Zzc2cG9ualJRTEVpdGxWcHdCd01BSFlFU1pWK0o3QUNXZitMcDdsVHdOdUNP?=
 =?utf-8?B?ZURFOElxMjcyREsvc2F6bmcxbjlETStnRlQ1Y0ZOK0pqQk15eGhQdnV5ZEkr?=
 =?utf-8?B?Wis1SDVFYktISWhvcWI2cVYzWkRsd25KNDZUVXk2VkdhYXhtd1hHUlk0dmN6?=
 =?utf-8?B?Ulc1c1pyVjdJZitTa016YWNodndrTmtPcVRwZ2d5RElKdkxwTklFcmRaOTRy?=
 =?utf-8?B?eVE4VzBtOVZyMGN5bFBjKzUrbEpHSmhMbXAvT200bjBrdHR4Y05HQUtSbS93?=
 =?utf-8?B?NXpWTnJoWWl2VXBnYTU2WnE5S2xCeTdXMUFlVnU0bHlEdDd2a0IzTDhTZDNS?=
 =?utf-8?B?aWdpNnRMVkxTSDFRODUwTVQ3YWo4WGRNNTZzb3NyV3F6L3paak5kK1YydGg3?=
 =?utf-8?B?TkN0K1hqbU9tS3Y3WVZzeGxwa0RCaEIxVUlxSERDM3BJcTVhYy9nUTZFV3BE?=
 =?utf-8?Q?fMp4An1gZB5zmL5+kNofQT8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bE5haVFWWEZDeHJSMEtsVEhXeVMrM1lpbDZ2Wkx5RTVLMjlMdi85Vm5DNnUy?=
 =?utf-8?B?eHdhSGRjVk5BZmMzTGlyTlJPbSs5VERyKzRlbmxrNklSV1d5NVlLWUprZ0ZH?=
 =?utf-8?B?ODk5S3BSQk9jWENCS1VEQmEwdjBXckozaUNYVFFMR2dSeDVjU0lqQTNYZC9h?=
 =?utf-8?B?YjE3ZGxtN3JlVTBpVWlvNllULzBGNzRCbWhqRDM2YWVxZ2x2KzcxL2k3d2ZL?=
 =?utf-8?B?TGl4YUR2RmM5R2ZoYTNzNVNIbDFObzV6NmFHcTRNRUFhK1A1SjREdlRDYzdJ?=
 =?utf-8?B?aDRRZ2d2SDVLc2pOditBMVM1Z1FUVzkyS3RlS3E4ZmVZOFQ4a1NwSlFsc1M4?=
 =?utf-8?B?QVZveFBoN2V5MElYT3hVVFhvOHdjdnZyZlJtdVh3cmNWZmxFUGFPSG9JQ0NF?=
 =?utf-8?B?MmQ3NXkyZVgwSGVTNm1yZnVtdm1aSkYvTERCMnc0cFF3akZ4V2xTRmt6emJN?=
 =?utf-8?B?a2p2NTBVcE1EVzJKcVFxM05WaUJEQW81cVFLVzBJS3gzSVRlSjVjZjAxMjlX?=
 =?utf-8?B?VmRVZndPTEsrR3lXeDBuc3pDMlVQTHI1TU9GSHp2TkwvR1F1R1MzaE51RHhW?=
 =?utf-8?B?V2VWN1VBOVZ0K1ZmcUVyN1E4aVh0NGg2aFRzWENRbDZVTmFCc3QwZlZvcUFD?=
 =?utf-8?B?UDhBMVZzWGQ0SUNPWGlqL2tybUFMUGMrWjBkUUtIR0VNeXpod2NReFUxWEgr?=
 =?utf-8?B?NVlnYU44R3BxQUM5WGhkcmRKQzFhS1RwMk5Za0JRbEZMUGNtYTJ5REpkS0g0?=
 =?utf-8?B?U0pGdk5aeE5MbkI3STEvTUplNTJCblZEYkYxbXdqT3FOaFVyQzVoVE1sVm8z?=
 =?utf-8?B?TjhaYlJMRFpBQ1NrL28wRmVwU1VSQkluNUppa3hwalFHVzI4MFZ5Uy92QW5a?=
 =?utf-8?B?SlJZT2gzQkIvcXBGek1HOEVSV3lDcGN4U1hSb3RBeGJ2RjZ0VU1nUnZqa3ox?=
 =?utf-8?B?NXNIMjJ0blIwTU9FeFBrbzhXbStBOTV6QWZiVmlwMXJDOGQ4OVRhaGhhYlFz?=
 =?utf-8?B?SXVLcUpuL292RW1Oald3eUVjNmZJVGZ5SnRvTWUvQ1ZJWjNTa3hJaTU3Y3dH?=
 =?utf-8?B?U1ZKZ1ZrODdoK0tGNWVrd3huSUd5OG0yR2hZL1pDZWVZSmtucWJONVVaOVBk?=
 =?utf-8?B?d1Rqc251RUNLWTF6bUIyakpQUWUvOWF5MGlXU2tWTVN4Q1ltK1UraGdKaHVN?=
 =?utf-8?B?WGZDRlBLakYyaWcwV1gxbHozWW1OQkhNa21DQlpWcE5JYjFZd2RpZjFKRDhV?=
 =?utf-8?Q?prYlM15dNwTuHxy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f0a9f0-da1c-4cad-12ba-08db45ab1bd1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:35:41.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6zZVaHPDDiq/fmFI6tkUTATH1sUD11j5rM4GW27JHuSIK7axCknmFSqJKkiy6kcWF605Bi7EvDDlu3nsrF+lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_07,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250149
X-Proofpoint-GUID: uRWqTerksrIRY0pOMpT1aDBxIb5JkgHc
X-Proofpoint-ORIG-GUID: uRWqTerksrIRY0pOMpT1aDBxIb5JkgHc
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/04/2023 15:46, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Support function or tracepoint parameters by name if BTF support is enabled
> and the event is for function entry (this feature can be used with kprobe-
> events, fprobe-events and tracepoint probe events.)
> 
> Note that the BTF variable syntax does not require a prefix. If it starts
> with an alphabetic character or an underscore ('_') without a prefix like
> '$' and '%', it is considered as a BTF variable.
> If you specify only the BTF variable name, the argument name will also
> be the same name instead of 'arg*'.
> 
>  # echo 'p vfs_read count pos' >> dynamic_events
>  # echo 'f vfs_write count pos' >> dynamic_events
>  # echo 't sched_overutilized_tp rd overutilized' >> dynamic_events
>  # cat dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read count=count pos=pos
> f:fprobes/vfs_write__entry vfs_write count=count pos=pos
> t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

A few small things below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Feel free to add a

Tested-by: Alan Maguire <alan.maguire@oracle.com>

...for the series (tested on x86_64; also built on
aarch64 but because of (I presume) lack of 
DYNAMIC_FTRACE_WITH_REGS, CONFIG_FPROBE could not
be selected there.

> ---
> Changes in v6:
>  - update patch description.
>  - use bpf_get_btf_vmlinux() instead of btf_parse_vmlinux().
> ---
>  kernel/trace/Kconfig        |   11 +++
>  kernel/trace/trace.c        |    4 +
>  kernel/trace/trace_fprobe.c |   49 +++++++----
>  kernel/trace/trace_kprobe.c |   12 +--
>  kernel/trace/trace_probe.c  |  184 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |    9 ++
>  6 files changed, 240 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 8e10a9453c96..e2b415b9fcd4 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -664,6 +664,17 @@ config FPROBE_EVENTS
>  	  and the kprobe events on function entry and exit will be
>  	  transparently converted to this fprobe events.
>  
> +config PROBE_EVENTS_BTF_ARGS
> +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> +	depends on FPROBE_EVENTS || KPROBE_EVENTS
> +	depends on DEBUG_INFO_BTF && BPF_SYSCALL
> +	bool "Support BTF function arguments for probe events"
> +	default y
> +	help
> +	  The user can specify the arguments of the probe event using the names
> +	  of the arguments of the probed function. This feature only works if
> +	  the probe location is a kernel function entry or a tracepoint.
> +
>  config KPROBE_EVENTS
>  	depends on KPROBES
>  	depends on HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 9da9c979faa3..0d9c48197a5c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5670,7 +5670,11 @@ static const char readme_msg[] =
>  	"\t     args: <name>=fetcharg[:type]\n"
>  	"\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<offset>],\n"
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>, <argname>\n"
> +#else
>  	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
> +#endif
>  #else
>  	"\t           $stack<index>, $stack, $retval, $comm,\n"
>  #endif
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 1dba45dfd234..a34081113fa8 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -367,6 +367,7 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
>  static struct trace_fprobe *alloc_trace_fprobe(const char *group,
>  					       const char *event,
>  					       const char *symbol,
> +					       struct tracepoint *tpoint,
>  					       int maxactive,
>  					       int nargs, bool is_return)
>  {
> @@ -386,6 +387,7 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
>  	else
>  		tf->fp.entry_handler = fentry_dispatcher;
>  
> +	tf->tpoint = tpoint;
>  	tf->fp.nr_maxactive = maxactive;
>  
>  	ret = trace_probe_init(&tf->tp, event, group, false);
> @@ -929,8 +931,12 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	int maxactive = 0;
>  	char buf[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
> -	unsigned int flags = TPARG_FL_KERNEL;
> +	char sbuf[KSYM_NAME_LEN];
>  	bool is_tracepoint = false;
> +	struct tracepoint *tpoint = NULL;
> +	struct traceprobe_parse_context ctx = {
> +		.flags = TPARG_FL_KERNEL | TPARG_FL_FENTRY,
> +	};
>  
>  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
>  		return -ECANCELED;
> @@ -994,12 +1000,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		goto parse_error;
>  	}
>  
> -	flags |= TPARG_FL_FENTRY;
> -	if (is_return)
> -		flags |= TPARG_FL_RETURN;
> -	if (is_tracepoint)
> -		flags |= TPARG_FL_TPOINT;
> -
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1011,7 +1011,8 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  	if (!event) {
>  		/* Make a new event name */
>  		if (is_tracepoint)
> -			strscpy(buf, symbol, MAX_EVENT_NAME_LEN);
> +			snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
> +				 isdigit(*symbol) ? "_" : "", symbol);
>  		else
>  			snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbol,
>  				 is_return ? "exit" : "entry");
> @@ -1019,8 +1020,25 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		event = buf;
>  	}
>  
> +	if (is_return)
> +		ctx.flags |= TPARG_FL_RETURN;
> +
> +	if (is_tracepoint) {
> +		ctx.flags |= TPARG_FL_TPOINT;
> +		tpoint = find_tracepoint(symbol);
> +		if (!tpoint) {
> +			trace_probe_log_set_index(1);
> +			trace_probe_log_err(0, NO_TRACEPOINT);
> +			goto parse_error;
> +		}
> +		ctx.funcname = kallsyms_lookup(
> +				(unsigned long)tpoint->probestub,
> +				NULL, NULL, NULL, sbuf);
> +	} else
> +		ctx.funcname = symbol;
> +
>  	/* setup a probe */
> -	tf = alloc_trace_fprobe(group, event, symbol, maxactive,
> +	tf = alloc_trace_fprobe(group, event, symbol, tpoint, maxactive,
>  				argc - 2, is_return);
>  	if (IS_ERR(tf)) {
>  		ret = PTR_ERR(tf);
> @@ -1029,24 +1047,15 @@ static int __trace_fprobe_create(int argc, const char *argv[])
>  		goto out;	/* We know tf is not allocated */
>  	}
>  
> -	if (is_tracepoint) {
> -		tf->tpoint = find_tracepoint(tf->symbol);
> -		if (!tf->tpoint) {
> -			trace_probe_log_set_index(1);
> -			trace_probe_log_err(0, NO_TRACEPOINT);
> -			goto parse_error;
> -		}
> +	if (is_tracepoint)
>  		tf->mod = __module_text_address(
>  				(unsigned long)tf->tpoint->probestub);
> -	}
>  
>  	argc -= 2; argv += 2;
> -
>  	/* parse arguments */
>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> -		struct traceprobe_parse_context ctx = { .flags = flags };
> -
>  		trace_probe_log_set_index(i + 2);
> +		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &ctx);
>  		if (ret)
>  			goto error;	/* This can be -ENOMEM */
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index fd62de2a2f51..aff6c1a5e161 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -742,7 +742,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	void *addr = NULL;
>  	char buf[MAX_EVENT_NAME_LEN];
>  	char gbuf[MAX_EVENT_NAME_LEN];
> -	unsigned int flags = TPARG_FL_KERNEL;
> +	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
>  
>  	switch (argv[0][0]) {
>  	case 'r':
> @@ -823,10 +823,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  			goto parse_error;
>  		}
>  		if (is_return)
> -			flags |= TPARG_FL_RETURN;
> +			ctx.flags |= TPARG_FL_RETURN;
>  		ret = kprobe_on_func_entry(NULL, symbol, offset);
>  		if (ret == 0)
> -			flags |= TPARG_FL_FENTRY;
> +			ctx.flags |= TPARG_FL_FENTRY;
>  		/* Defer the ENOENT case until register kprobe */
>  		if (ret == -EINVAL && is_return) {
>  			trace_probe_log_err(0, BAD_RETPROBE);
> @@ -856,7 +856,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  
>  	/* setup a probe */
>  	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
> -			       argc - 2, is_return);
> +				argc - 2, is_return);
>  	if (IS_ERR(tk)) {
>  		ret = PTR_ERR(tk);
>  		/* This must return -ENOMEM, else there is a bug */
> @@ -866,10 +866,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  	argc -= 2; argv += 2;
>  
>  	/* parse arguments */
> +	ctx.funcname = symbol;
>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> -		struct traceprobe_parse_context ctx = { .flags = flags };
> -
>  		trace_probe_log_set_index(i + 2);
> +		ctx.offset = 0;
>  		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &ctx);
>  		if (ret)
>  			goto error;	/* This can be -ENOMEM */
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 84a9f0446390..de30b6add9af 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -11,6 +11,8 @@
>   */
>  #define pr_fmt(fmt)	"trace_probe: " fmt
>  
> +#include <linux/bpf.h>
> +
>  #include "trace_probe.h"
>  
>  #undef C
> @@ -300,6 +302,164 @@ static int parse_trace_event_arg(char *arg, struct fetch_insn *code,
>  	return -ENOENT;
>  }
>  
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> +
> +static struct btf *traceprobe_get_btf(void)
> +{
> +	return bpf_get_btf_vmlinux();
> +}
> +
> +static u32 btf_type_int(const struct btf_type *t)
> +{
> +	return *(u32 *)(t + 1);
> +}
> +
> +static const char *type_from_btf_id(struct btf *btf, s32 id)
> +{
> +	const struct btf_type *t;
> +	u32 intdata;
> +	s32 tid;
> +
> +	/* TODO: const char * could be converted as a string */
> +	t = btf_type_skip_modifiers(btf, id, &tid);
> +
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_ENUM:
> +		/* enum is "int", so convert to "s32" */
> +		return "s32";

you could add
	case BTF_KIND_ENUM64:
		return "s64";

...too I guess.

> +	case BTF_KIND_PTR:
> +		/* pointer will be converted to "x??" */
> +		if (IS_ENABLED(CONFIG_64BIT))
> +			return "x64";
> +		else
> +			return "x32";
> +	case BTF_KIND_INT:
> +		intdata = btf_type_int(t);
> +		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
> +			switch (BTF_INT_BITS(intdata)) {
> +			case 8:
> +				return "s8";
> +			case 16:
> +				return "s16";
> +			case 32:
> +				return "s32";
> +			case 64:
> +				return "s64";
> +			}
> +		} else {	/* unsigned */
> +			switch (BTF_INT_BITS(intdata)) {
> +			case 8:
> +				return "u8";
> +			case 16:
> +				return "u16";
> +			case 32:
> +				return "u32";
> +			case 64:
> +				return "u64";
> +			}
> +		}
> +	}
> +	/* TODO: support other types */
> +
> +	return NULL;
> +}
> +
> +static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const struct btf_type *t;
> +	s32 id;
> +
> +	if (!btf || !funcname || !nr)

I _think_ you need IS_ERR_OR_NULL(btf) handling for the struct btf * here; 
btf_parse_vmlinux() mostly returns ERR_PTR values, while btf_vmlinux
can be NULL if BTF isn't present.
 
> +		return ERR_PTR(-EINVAL);
> +
> +	id = btf_find_by_name_kind(btf, funcname, BTF_KIND_FUNC);
> +	if (id <= 0)
> +		return ERR_PTR(-ENOENT);
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +	if (!btf_type_is_func(t))
> +		return ERR_PTR(-ENOENT);
> +
> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +	t = btf_type_by_id(btf, t->type);
> +	if (!btf_type_is_func_proto(t))
> +		return ERR_PTR(-ENOENT);
> +
> +	*nr = btf_type_vlen(t);
> +
> +	if (*nr)
> +		return (const struct btf_param *)(t + 1);
> +	else
> +		return NULL;
> +}
> +
> +static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> +			 struct traceprobe_parse_context *ctx)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const struct btf_param *params;
> +	int i;
> +
> +	if (!btf) {
> +		trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (WARN_ON_ONCE(!ctx->funcname))
> +		return -EINVAL;
> +
> +	if (!ctx->params) {
> +		params = find_btf_func_param(ctx->funcname, &ctx->nr_params);
> +		if (IS_ERR(params)) {
> +			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
> +			return PTR_ERR(params);
> +		}
> +		ctx->params = params;
> +	} else
> +		params = ctx->params;
> +
> +	for (i = 0; i < ctx->nr_params; i++) {
> +		const char *name = btf_name_by_offset(btf, params[i].name_off);
> +
> +		if (name && !strcmp(name, varname)) {
> +			code->op = FETCH_OP_ARG;
> +			code->param = i;
> +			return 0;
> +		}
> +	}
> +	trace_probe_log_err(ctx->offset, NO_BTFARG);
> +	return -ENOENT;
> +}
> +
> +static const struct fetch_type *parse_btf_arg_type(int arg_idx,
> +					struct traceprobe_parse_context *ctx)
> +{
> +	struct btf *btf = traceprobe_get_btf();
> +	const char *typestr = NULL;
> +
> +	if (btf && ctx->params)
> +		typestr = type_from_btf_id(btf, ctx->params[arg_idx].type);
> +
> +	return find_fetch_type(typestr, ctx->flags);
> +}
> +#else
> +static struct btf *traceprobe_get_btf(void)
> +{
> +	return NULL;
> +}
> +
> +static int parse_btf_arg(const char *varname, struct fetch_insn *code,
> +			 struct traceprobe_parse_context *ctx)
> +{
> +	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +	return -EOPNOTSUPP;
> +}
> +#define parse_btf_arg_type(idx, ctx)		\
> +	find_fetch_type(NULL, ctx->flags)
> +#endif
> +
>  #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
>  
>  static int parse_probe_vars(char *arg, const struct fetch_type *t,
> @@ -556,6 +716,15 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  				code->op = FETCH_OP_IMM;
>  		}
>  		break;
> +	default:
> +		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
> +			if (!tparg_is_function_entry(ctx->flags)) {
> +				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
> +				return -EINVAL;
> +			}
> +			ret = parse_btf_arg(arg, code, ctx);
> +			break;
> +		}
>  	}
>  	if (!ret && code->op == FETCH_OP_NOP) {
>  		/* Parsed, but do not find fetch method */
> @@ -704,6 +873,11 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  	if (ret)
>  		goto fail;
>  
> +	/* Update storing type if BTF is available */
> +	if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
> +	    !t && code->op == FETCH_OP_ARG)
> +		parg->type = parse_btf_arg_type(code->param, ctx);
> +
>  	ret = -EINVAL;
>  	/* Store operation */
>  	if (parg->type->is_string) {
> @@ -857,8 +1031,14 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
>  		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
>  		body++;
>  	} else {
> -		/* If argument name is omitted, set "argN" */
> -		parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
> +		/*
> +		 * If argument name is omitted, try arg as a name (BTF variable)
> +		 * or "argN".
> +		 */
> +		if (is_good_name(arg))
> +			parg->name = kstrdup(arg, GFP_KERNEL);
> +		else
> +			parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
>  		body = arg;
>  	}
>  	if (!parg->name)
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 2dc1e5c4c9e8..9ea5c7e8753f 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -23,6 +23,7 @@
>  #include <linux/limits.h>
>  #include <linux/uaccess.h>
>  #include <linux/bitops.h>
> +#include <linux/btf.h>
>  #include <asm/bitsperlong.h>
>  
>  #include "trace.h"
> @@ -376,6 +377,9 @@ static inline bool tparg_is_function_entry(unsigned int flags)
>  
>  struct traceprobe_parse_context {
>  	struct trace_event_call *event;
> +	const struct btf_param *params;
> +	s32 nr_params;
> +	const char *funcname;
>  	unsigned int flags;
>  	int offset;
>  };
> @@ -474,7 +478,10 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
>  	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
>  	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
> -	C(NO_EP_FILTER,		"No filter rule after 'if'"),
> +	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
> +	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
> +	C(NO_BTFARG,		"This variable is not found at this probe point"),\
> +	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),
>  
>  #undef C
>  #define C(a, b)		TP_ERR_##a
> 
