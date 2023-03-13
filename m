Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E26B78AD
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 14:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCMNRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCMNRZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 09:17:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018E13DF7
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 06:17:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCArMT028436;
        Mon, 13 Mar 2023 13:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tH9OZ3hgpG0UU7zGnqwNwuXF5GXuy2zINaWXxA+mT7Y=;
 b=pNyUCLWhOS1+9Tc3MhG9maQyhpN2VYwC1jpsbK9U9vgCEdCsMYUP1a0xDmxf8gJ1hFHs
 mTMpJn4YZD4kcqm58tc/aIGg6OT9Xoy8WUyGd0KkVp10pByAbrzKJcFN1izDf5vaQBsu
 0msY/wuuTlEfgOYica10RiIRTh0g0SbEqtmweZJdXNCM0sUNZwwZH3HGPSXikzRK5oT9
 qdtEk08BI57+FGJSD3swwUWShy/+GgPMvhXvcek8hE238CHRm48CioWbqisgBgLQCRNI
 4jSpwN9v+Uw7N4uNnW9/+pyzslc9DMTn6Q8zzJvkovhuTjHjHYY+lOAACCzGJDZHym6e TQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g81bufm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 13:16:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DCqMSu015303;
        Mon, 13 Mar 2023 13:16:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g354qjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 13:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkKyLQUfl5SkPFNbL10CXMGpqYL+ZfKeJKuNUxCOvQ9vm2JpYdiQj04pZC8ruKV16l3rac7RcPdA3BtvPIY+CcZtNv40jeTH9xDM7SMDZIrq3Y8gg/JnQ64xUFRut4Fp5Hs782kGvrAYb4gmDm5eeNPVQ8W0YnPuSwiOwDR6sB6QS2kr9Oaf23CboLikn3ShIGdgrqYWLeRtf8kpcQm5OZZNDbrxbkBRqt7vSJI1V8g21ZLFUv6ymqNGkPHCfQxUdlzNRspmKOgaGYB3NzNjymg9EKjkIR3XUripjT9ctKztqzYlSSthwBR5CbEN4eRIrkRZt5uegbu+zCCzxHzjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH9OZ3hgpG0UU7zGnqwNwuXF5GXuy2zINaWXxA+mT7Y=;
 b=ULgmb6Yz+CorK6G01XJskZ2Tfgd2dMDDEaFs9rwbXQq+H45nmJJnR8Q6T9mR3ProtUgOfqzxaKTUO6Mf8Wp8iDFgiv0oJiveA8SVw8S3Q7nzhuoSnugtj1G/KD7AzEtyOEy6B5+K/iOXpxfBbCUF+XsDAt2bdrf2nVYheFzl+9G3zLDZ/G4oYaX8NzXVSo6VrHzrPHVNVfZY3KyK8JW8PdOE90FdVxPU8+Ocwm/938BAe4iO7vkvUVB0RN62wdBGl3UQrzMyMVdoUHX0FCmM7RIIzAMn5KfO/zWBiYnet8jjAqKiKXgBSdrEQNToA+lSmkrMLg+tFxxjr4gqIco52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH9OZ3hgpG0UU7zGnqwNwuXF5GXuy2zINaWXxA+mT7Y=;
 b=QMVCQ5PW1dkxWUPX8O86Fz+qpslQzbHYsUjaQAom1QjuZnp2vA+KuuqJJsJhkdFor8pb4o7qBJYWUbM8yHF5sRDwwj4GwKd8AYnqYc3O8Su8TCNWQCkkN5QcyOtX2M8QgyUOmIEL0/nUfEbF0AemLA1qq3szQuAdcsbviZsXQEA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:16:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1c91:fd13:5b72:4be6]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1c91:fd13:5b72:4be6%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:16:53 +0000
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
 <ZA8VEfKWuQYH/Jnx@kernel.org> <ZA8XRweCvk6CZIly@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <44d0d871-e78d-1693-afd0-117b5f143a79@oracle.com>
Date:   Mon, 13 Mar 2023 13:16:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <ZA8XRweCvk6CZIly@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: ee664de6-11b8-4a01-0671-08db23c5361d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izBYQemtwWenrjsXrg5pvji1cgbQeAzyLWDt9GuPwxTe0PybmLYx17YJO94FPtLlFgritCGaqV93EFtCLuwqoYFCLREMSn4BPsWCI2d9W91yVvn3MLWekruKpyQ7YBdL3kkOK2W9MYoSZfWhUnMVnkbdjSnuTJgjffcxci6OqmQOzaz/wKYyqcl4TJ2XGabnW60kwqPEo11rp7ZWmiNnnpsuDB/Jg6ZvwZ6pcVARriME8uXN1aXwhJX7MDxaL2pBGj6BWBZ6eahDLydMuiQxZIEEzdgACvgJ4GpXZnuZd6ob9dVHPy4+ldBZrJP7XCJOycCXv6p+BSguZBxF0wpGSbsA9U8BnBnvWe1+NhZXu37pKdxlRQcNlDtlFIgMnZMVTb5m/E1I6kVSWELrn7Ftk8dMRMRBYBOe0vJBLUpQ1xaKyyMmPfbQqfNPxwyN8OxLv4F5OuVqVqfIh9hBblmO18c8cZhHyoL5RKjxp8rj0qJYbkTiKxsOcmsnzs6jefzzZ38DhOltaWCbiKo5TZnEFz5QhXAAyUx28zgLHXCYMOPxRe1HfpGIj92Q0UVYe2Lq6qhMR9uHPRgn4cqYLscn03yjmuPudNEgxfmXqKkmL5wPjIJVV89hbFuI9HgCCXDmCuWfgkvLTQryofaO8XXoKO+Nxfnz8TYvdEMe2dOJfFb9KPp+yvSCNxCXoQaJUUqxIP++itXcs4KkNIMnBTgY1dN78Vs9Xg6bmHfrYmARsQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(6666004)(83380400001)(316002)(38100700002)(478600001)(6512007)(8936002)(186003)(8676002)(6506007)(36756003)(5660300002)(53546011)(6916009)(4326008)(7416002)(66556008)(66476007)(66946007)(41300700001)(31696002)(86362001)(44832011)(2616005)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpsL2tNSTNnZ2tLZ3Y0eElwZDdVd1JHanJIbUxvUW55bHYvbkZzR2U3YkY5?=
 =?utf-8?B?SEtEWEZ4RWpveHJzeVZhVm0ycTVKTjc4QUFqWnQ0WXJTVjR5eUZvNXRacHVq?=
 =?utf-8?B?Y2czQXVxN2hUUitmWGs2WmpPczRnT2k3d3UvVUxFcFlPeVJsZnNiazRydGlS?=
 =?utf-8?B?Z3dBYnFvd1Nod3VLeUJqNVJFZUpRbHMxVlpIV3A4UStsdGYwVVAvOERWUG1U?=
 =?utf-8?B?VUUyOFRPRE5BN3B2d2ZJRGx2ZmpqVmNNdUpmM3N6WHh6ZEVla2Rpa3Q3YXVQ?=
 =?utf-8?B?cWo3VmlMc2hTSEhES1ZOczE0c09ReWtrc25rVzFtME92MTRzRXVsTmxIT3Jy?=
 =?utf-8?B?OUFIbytrdUs2MmM3MUdSbU53SVVUTXlocEFFOC82YWpQdUR3cTVzWnZlcDZi?=
 =?utf-8?B?UDVHOC8yTFNjRmJ4ODdreWFTOEtaUkR2c0VBVXVzcU5CTFYxME83a0tSS2VQ?=
 =?utf-8?B?SDhNVGlpZG5qM3l5TUgxeXNQeDBHQzZjdWhvTmd1ZTF5Z21Uci96cEtvb1BD?=
 =?utf-8?B?QU9kVTNrVjZTWkdyYTdrUkZXRW9qaStxd3FpVEJ2S0NRWkFRWDRwUlA3S2t6?=
 =?utf-8?B?T0ZrcytZY04rV3JibGJDVHdRL3ZYY01jYW5pdGpKQnpRWW5iRlQ3bllDQUc5?=
 =?utf-8?B?bWRDT3F3M0NBZlNWbm1NQ25JNEtSVThBWmpQTFlWdG0yQTJwcFI2L2RQS3Ex?=
 =?utf-8?B?TEFDaUg3bUtrdmxEcUVCdzhzdHNLeVRld0hoNnNoZHkxdUhRclBCY2M2QytZ?=
 =?utf-8?B?ODZjRFJCTTNDT0VIRVFuTFZoZUxmeXhPSlowVEZ4TFk5Ukd6dHlCL2hVZmc3?=
 =?utf-8?B?dm9GZHJsd0hxcmtrMHR0SGRmMGZ3bHMvY2FBTUM5Z0hpNkF0TmtmcHRjUWZ6?=
 =?utf-8?B?WU5jb1F2UjE0VWhXY2NqYVUrNGpkNW9yT0VBUWx4YUdyYnVZZzJ4MkE5cHg2?=
 =?utf-8?B?UnJXMlFOTUVZdUpnbHJER2NZRVlseVhOOFFzM05qWlRCMEV0VGxFSGFqYXF4?=
 =?utf-8?B?em41VDJtbW01NGR1bitKb1JGanR6Yi9idHhqOVZLSi8rNVcvNGZVUUpVN2Nu?=
 =?utf-8?B?SkgrRHM1aGVaVDBrY3JTVHJlRUhZTS9xVmY0Qk9iU1pYTTRRZFp3ZzRZUkJq?=
 =?utf-8?B?VnJtV0JrU1ZmZ2tUNmtqTUVDU21HWlNDcHBmcGsrUWVmRWE3MHVkTHVZUkRJ?=
 =?utf-8?B?QXZ0SFR2K0JsSnYzRWtpTVdmeW5SSlh5NlVPaGVpS1lBdDZGWHFHR1NpNzNu?=
 =?utf-8?B?UUVVSUxqYmt6ODFlTklkYjVnMlBnaVJpVmUyOUZRZ3lWMk9LT0RpZ21sMHpV?=
 =?utf-8?B?WWVHSTFkR0NwQmJBcVZ0VmdERmFjU0cwZVZBMHQ0bFhpN2xLTFZLV0FLVitM?=
 =?utf-8?B?YTV4eElkeE8rNzlFSVo4ZFRscVFlU2VxRTRBODE4TjI5a1NqV1VJQjhBVHFP?=
 =?utf-8?B?eWVubmJtMjVYWWJFVkc1Nk5mcmxnYVhVYkRWeTVQSEpSY3lZaDI5WFlZSW1W?=
 =?utf-8?B?aGxNb0F6TUVzbDdHMUcwK2hpWGsvWVpWeWtGbkZWMlFxcDFMdVhONzFFaFdv?=
 =?utf-8?B?bU9GOU1wazYyNXp2L3VqbDNaUSt4VkJoTC9mK0hmV2JPSFljRXUvVW8yMkdr?=
 =?utf-8?B?R2NUdEMxYXdyTkp4M3NzVXduckJkUmNmemU5bFp3NTRMb1RzbUNtWFBZOC8r?=
 =?utf-8?B?bXlRb2Rja0hKQWlMOVlBNG5LMFZ3VjNGWXg1SUpoUnJTMXl4aGgzaU9HRTRi?=
 =?utf-8?B?Mk1LbmJuQ3I5b0cyeFhMRnJsTkdTbjd6MTRGLzRXLzIxVks1ZmhSL3ZjZU9W?=
 =?utf-8?B?RitBVjczbThQSTJVWVJkc1FLN0E5M0FOWDE5dVl0ODA4dDhNMU5TYXhMRTJU?=
 =?utf-8?B?VnUzcVk3d0dJRmx4bUFEamlhZHlWUVR6WnJXUmh6RTh6RnV1UGp1T0ZLd21B?=
 =?utf-8?B?RGt6VzhMU0ZQaWNhRnYvT3NUVi9jOW1CMG1USHVWUWxqVVpKZFMwc1Y5clFI?=
 =?utf-8?B?ak1icFJ2UjRmVU9TN3dJWDd6VmpURmhDYnFOZ0pWVjVBa0VFT0NVL3dpOTJk?=
 =?utf-8?B?Nm9nUXdlbE94RlpXbTNuSTNwdXR6dzU5Rit6Rlk1VUtTLzROUjZoRUFUR3VF?=
 =?utf-8?B?SGNhQTlOcm1RSHNBclRTSU90U0NlcEZiZmRRSVJURlB1RVZGa2krckRuajJZ?=
 =?utf-8?Q?FtmqUzy0EeygSrQJz5MSGeo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S3FBcVkzcTJndjVVQkJSYkVUWTc1ZnF1cUtWTThybitYMHdkZVByLzNhNFN4?=
 =?utf-8?B?V1gzQ0tNUll4WjUrcjhMUlhHK2Q2YXViUktyY01acW9mWmV5RlNaSjJ5NG1X?=
 =?utf-8?B?WFBCYW02Q2d0TTlHa3lpL1Y5WmFGOXBzWGR6SWhyTGRDb0pnVW9XeUt6Zmt2?=
 =?utf-8?B?M3JheFY2OXh6UFRYUXljdUtmRFJOcjZBUUhBTjRQK2lWeFVpMG5vR2MxQjV5?=
 =?utf-8?B?NWlrN2VJSXBwODNiVmZRdHg0cDU2dXppYUlwaUh3OWcwTGlPMXNPaGtPaWxt?=
 =?utf-8?B?YllheVFIUXJpK1Q1QTF3M2txUmU1MUZSMi9yM2x3NFkxeG5QeE5hcmFGRCtv?=
 =?utf-8?B?cW40dWlITnBRVkoxSE1Id2x4bzdLRlp1dDU5S1MwNlVYQXpmT1ZKSmgzVzdv?=
 =?utf-8?B?MHdpaDBHZ1pUQmo4V0g5aXhFSWF6bGRtTEZSM1pMaDFTOHJ6c1ZNR2l3RUxw?=
 =?utf-8?B?a0J2dkh1Nkl4WTk5MlRGOHo5R2Q2cUg0ekd1SXlEK0pwbGJRMEoyWnJzYThk?=
 =?utf-8?B?eWgyeGlPeUcvc0wwYXJ5ZUtRQis4dDVrdVdNSFQ4Lys5Sm1OMW9VTWpsNkhH?=
 =?utf-8?B?VjdMVmt0R0pDbVZocFFXREJWSW95YkFEUk9CNHpNWHFKa1FQZVlMN1Y0S3pI?=
 =?utf-8?B?dG1XTEQxVUh1N1FJUXFVS2hnYkZKKytLVGhtMkNmZm9MRmZHMWVvVnN2eXNE?=
 =?utf-8?B?MnFQUUp3MW9CYkh0YzM0R0hRbzF4NG15S05mSXV1bDFrdDFHcHY5YzRwcnVa?=
 =?utf-8?B?aG5ZUXNvdktzOHBCV0tzdUE5a1FBY3p4SjZwak1xeVkrcERrYXNhbm1rWVFJ?=
 =?utf-8?B?YUpHdEtRZEhVWnZ4Tnl4YUVHbS9DdXNkMjZTMG9KYnBGclIrUlQ4YWlacFV0?=
 =?utf-8?B?b0JlRFVGWnNCL3ltYWNBK3Z0UGdUS0paRFZVaVRDZ3FGbmdnekwyelFEWWxU?=
 =?utf-8?B?aHJpNHYxUFlheWIvSExSYjNuaWNVb09yN2dZQWNiTHVZYUZSMVVHTmNQSmto?=
 =?utf-8?B?UmZmSnpQdmhkVjY2Tm9DRnVDdkdvamQ0b1JNS3JVUmFLL1ptdjM3bkMzOVRH?=
 =?utf-8?B?dGdaSFI5ZUdneHpIQzVXdVJBekZMTHpVNEFibGx6THNTZ3N4L3ZYbDZLRDZq?=
 =?utf-8?B?MVpGU2wzVGVJem5YdWFGK3hvcVlPTTZkalp3azhIUWN4d1VzaGJWWkJxNG5C?=
 =?utf-8?B?bDR6bVdlMnljL0VuZ0RwSEs0ZG5rYU03VE5ERm1LZkErTjAyUVpQVGFoNWNE?=
 =?utf-8?B?cTlTUExzU1psaDZ0ajIreFY4Y2tUb1VVUThPZm9kb1hyZEJYdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee664de6-11b8-4a01-0671-08db23c5361d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:16:53.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o923+U9znDnBjzeTCgR2bI7QvGjYpV61O/MsXQ9x2/JfMsuzvkRpQUA/f8/e41MVjR7TfCIBsIA8Cadj5ES+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130107
X-Proofpoint-ORIG-GUID: Ds0QO9woKI4eT8EgWzSIZ5S5jS26Mpn3
X-Proofpoint-GUID: Ds0QO9woKI4eT8EgWzSIZ5S5jS26Mpn3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/03/2023 12:29, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 13, 2023 at 09:20:33AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Mar 10, 2023 at 02:50:49PM +0000, Alan Maguire escreveu:
>>> When doing BTF comparisons between functions defined in multiple
>>> CUs, it was noticed a few critical functions failed prototype
>>> comparisons due to multiple "const" modifiers; for example:
>>>
>>> function mismatch for 'memchr_inv'('memchr_inv'): 'void * ()(const const void  * , int, size_t)' != 'void * ()(const void  *, int, size_t)'
>>>
>>> function mismatch for 'strnlen'('strnlen'): '__kernel_size_t ()(const const char  * , __kernel_size_t)' != '__kernel_size_t ()(const char  *, size_t)'
>>>
>>> (note the "const const" in the first parameter.)
>>>
>>> As such it would be useful to omit modifiers for comparison
>>> purposes.  Also noted was the fact that for the "no_parm_names"
>>> case, an extra space was being emitted in some cases, also
>>> throwing off string comparisons of prototypes.
>>
>> Running 'btfdiff vmlinux' after this change ends up in a segfault:
>>
>> ⬢[acme@toolbox pahole]$ btfdiff vmlinux
>> /var/home/acme/bin/btfdiff: line 34:  8183 Segmentation fault      (core dumped) ${pahole_bin} -F dwarf --flat_arrays --sort --jobs --suppress_aligned_attribute --suppress_force_paddings --suppress_packed --lang_exclude rust --show_private_classes $dwarf_input > $dwarf_output
>> /var/home/acme/bin/btfdiff: line 39:  8237 Segmentation fault      (core dumped) ${pahole_bin} -F btf --sort --suppress_aligned_attribute --suppress_packed $btf_input > $btf_output
>> ⬢[acme@toolbox pahole]$
>>
>> Investigating.
> 
> (gdb) run -F dwarf --flat_arrays --sort --jobs --suppress_aligned_attribute --suppress_force_paddings --suppress_packed --lang_exclude rust --show_private_classes vmlinux
> Starting program: /var/home/acme/bin/pahole -F dwarf --flat_arrays --sort --jobs --suppress_aligned_attribute --suppress_force_paddings --suppress_packed --lang_exclude rust --show_private_classes vmlinux
> Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7f26cff in __tag__name (tag=0x7fff88016a20, cu=0x7fff88001e30, bf=0x7fffffffce90 "void ()(void)", len=1024, conf=0x0) at /var/home/acme/git/pahole/dwarves_fprintf.c:584
> 584				if (!conf->skip_emitting_modifier) {
> (gdb) bt
> #0  0x00007ffff7f26cff in __tag__name (tag=0x7fff88016a20, cu=0x7fff88001e30, bf=0x7fffffffce90 "void ()(void)", len=1024, conf=0x0) at /var/home/acme/git/pahole/dwarves_fprintf.c:584
> #1  0x00007ffff7f26873 in tag__ptr_name (tag=0x7fff88016990, cu=0x7fff88001e30, bf=0x7fffffffd9d0 "long unsigned int", len=1024, ptr_suffix=0x7ffff7f88fb0 "*", conf=0x0) at /var/home/acme/git/pahole/dwarves_fprintf.c:515
> #2  0x00007ffff7f26acd in __tag__name (tag=0x7fff88016990, cu=0x7fff88001e30, bf=0x7fffffffd9d0 "long unsigned int", len=1024, conf=0x0) at /var/home/acme/git/pahole/dwarves_fprintf.c:551
> #3  0x00007ffff7f270d5 in tag__name (tag=0x7fff88016990, cu=0x7fff88001e30, bf=0x7fffffffd9d0 "long unsigned int", len=1024, conf=0x0) at /var/home/acme/git/pahole/dwarves_fprintf.c:639
> #4  0x0000000000404042 in type__compare_members_types (a=0x7fff9401bc30, cu_a=0x7fff94001e30, b=0x7fff8801bba0, cu_b=0x7fff88001e30) at /var/home/acme/git/pahole/pahole.c:258
> #5  0x0000000000404cd0 in resort_add (resorted=0x7fffffffded8, str=0x7fff8801d120) at /var/home/acme/git/pahole/pahole.c:649
> #6  0x0000000000404d7e in resort_classes (resorted=0x7fffffffded8, head=0x411420 <structures.list>) at /var/home/acme/git/pahole/pahole.c:668
> #7  0x0000000000404dda in print_ordered_classes () at /var/home/acme/git/pahole/pahole.c:678
> #8  0x000000000040a93c in main (argc=13, argv=0x7fffffffe068) at /var/home/acme/git/pahole/pahole.c:3528
> (gdb)
> 
> I'm adding this:
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index b20a473125c3aa41..c2fdcdad078a5335 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -506,7 +506,7 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
>  				struct tag *next_type = cu__type(cu, type->type);
>  
>  				if (next_type && tag__is_pointer(next_type)) {
> -					if (!conf->skip_emitting_modifier)
> +					if (!(conf && conf->skip_emitting_modifier))
>  						const_pointer = "const ";
>  					type = next_type;
>  				}
> @@ -581,7 +581,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  				   *type_str = __tag__name(type, cu, tmpbf,
>  							   sizeof(tmpbf),
>  							   pconf);
> -			if (!conf->skip_emitting_modifier) {
> +			if (!pconf->skip_emitting_modifier) {
>  				switch (tag->tag) {
>  				case DW_TAG_volatile_type: prefix = "volatile "; break;
>  				case DW_TAG_const_type: prefix = "const"; break;
> @@ -590,7 +590,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
>  				}
>  			}
>  			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
> -				 conf->no_parm_names ? "" : " ");
> +				 pconf->no_parm_names ? "" : " ");
>  		}
>  		break;
>  	case DW_TAG_array_type:
> 
> 
> With it:
> 
> ⬢[acme@toolbox pahole]$ btfdiff vmlinux
> ⬢[acme@toolbox pahole]$
> 

thanks for finding and fixing this!
