Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237369D443
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 20:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBTTm4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 14:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjBTTmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 14:42:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8086B10A93
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 11:42:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KGiSFS010941;
        Mon, 20 Feb 2023 19:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ytb6J9Usq39fdyv4mlRBrsMY/xpt7DN/+LWYSrdBwQE=;
 b=IAVz/2pRotA5XLLFpr4Xw7w8uZ7KWJzbGaO3J/A0c2JT6YhMqj3bBT9saOlWBjxZkurT
 msyQyO5W60I7AxRDCDZJM1VQ2iEYhnr4qQVAE5NMbUHgUAsLjHF332L536HvFZtbhGMl
 ai6E9vn1P3MRpgID2SueF5H1l+iGErcv0OfeaM/H8K0GBLII51VN70YYgcCjZdNeUx6b
 2N4fOu5FcA0hEU/tf8dyIsdgAqilyGwD7DhffToGQvbrM8ybff+IGsf5glYXGlfDPAiM
 5nxi3rrN1xvYlj9GjWzTCZR7UvvnpuGPc2XjfZPoobL3aKrAQ5lsaqnW9mgMmM/01W4V SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja3mqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 19:42:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31KHSAJ6027280;
        Mon, 20 Feb 2023 19:42:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn44h3wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 19:42:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVJ0VSfSUqwnNgJKxcNtpI+HeYBTygZmvvUNxvtkfwOmZoJ00z9IgBqQHdLWgdwC1l1GZfTtCMcgRsbajimydQa1y6GSFi4PdTWsQyMJFD8wL7jN6+REQqUhCsSp0D3OFrSh7zoOHNTX7Ddzw/t+mGcerN7Q91m8TVyYcwqRSlp/LnT3ZzrDUx64Qe6qeCUPhoJWtOwh2r2ruSgt1y4K+2/oQ685ZJXjPbXPmxyNL9yaxjPjFb/tkxe4B78mAOVlAVpCYBcu52H9eFu6nT4MGzdIqqfwGUje04wdZpeDNMg/lnbrijf+9DzcCn0eQV5UeioLqF0fPaWQCzLaEA2fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ytb6J9Usq39fdyv4mlRBrsMY/xpt7DN/+LWYSrdBwQE=;
 b=nSQ6iolE/pWDf8FXkaI50MSrwIbVHTrgpJg7DqZi4WHI11VzeiMHOrqR8wUev+oeZFRcpPv7SyMMQxMRL0Sf57R6V/0OM8gmEKZQ2B0krRG6E0MW99uNxPUg/kar320XbsT9uAmeCIkrDACGWmrZ2i+jyhdatSCYUgKZu/cvoqk17I6uoR2y/qusANcR+C5ZzF7Us0k6eSU8j3ZWlStRj1stthXvYoDiD4ALfhYouxkrOBLRf9pC0IUXT5p/MuKTjJr/Bk/RcEcWVgQsePovYWVDrLbiQemokOngUG7Cbe9jO5ZkmvTjW2Ebl8nSoMkN4M6XrPk+N1ZFfiE8/dTjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytb6J9Usq39fdyv4mlRBrsMY/xpt7DN/+LWYSrdBwQE=;
 b=T0dmaUK08dRqODo4y5e6F2sIe0BTlYZN3fbAe14URyaR7kElOKTJLwMQuVb7vVarV1O5tTrV+UNzg0QttW98HE7yPh89me9sDSjJG+zj/69Inc6RGx/mNJ1xJaPWnI/Ha7PJUI+op931K8/hMEbnKpHdTuyw5brrONJuPrndDyM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB5702.namprd10.prod.outlook.com (2603:10b6:303:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Mon, 20 Feb
 2023 19:42:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6134.016; Mon, 20 Feb 2023
 19:42:21 +0000
Subject: Re: [RFC dwarves 1/4] dwarf_loader: mark functions that do not use
 expected registers for params
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
 <1676675433-10583-2-git-send-email-alan.maguire@oracle.com>
 <20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <0bf3e832-ef5b-6ab5-4d8b-1de8e957e166@oracle.com>
Date:   Mon, 20 Feb 2023 19:42:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:208:122::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7f9b5d-bd18-4413-c913-08db137a955a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pHj8reyNePLz2JNNneJVHZA6EychVZYbOj0FDscVYjmJ08SMd3/W0+inqAHiC5iX+tgUR0TbJ2ek1M16zhusxv6dB6x2VRu0wxami9h1A/oupIAW2tl0yv53wo1QkAXUOdhkrvHP9cP/V5r64hBFiC8oYpN0OrHup463z/9qMeK97qLpsZobkCXf1IOYx0IWnSWkolnmiqS/yp3P811fuAyQiHE3ASoD+BjWD4R9BDj2D1i50gZPBBrnPkqA37LIOKxw4Gh+k1591OAdr/EhSJ2Z1XdMW1+sLCzJbX5Sx1ZMAxUdYIphbzQGKf69POEVyP+eYGDl7q8dvwf0KMwG99wS5kGnu8REV+j8uEOONlfDseW9UXLq7PE2EXnagz8g72RWUtWMeQKnU4cUBHJCUiGY8ljEc5d+Zv+MP5OeMnYg7qTKxhcQGxAf7W52W0IpekK8chzIITthacDUSyNIkr+lOjiIw4ExZGPQ5ieQ5P5ghvf8ZVBCFgrje9peivVRKqnTLmGXPc8mkilCaDFLInR8GAjcn9eJMqHM56/MnK7TH7PlBZAnUAEgD5J0pNXjT4YvSOKtGLnZUBculLSIGnf+scVZ0vZc1zuXfeHoSaQMkwGrF8c0eh9vahPsHFdF517TcRQwDX2BNxlxoN11QJH80vno5Do6yQCRKWqPBjBlarWuiPdSe3GoJ2lwUagAZapc5XM/3QsT0L/1SctbdpyM0PoEcMkWL3zeD3zduU+WCh15KTOHI4S5f0DHqMx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(38100700002)(31686004)(966005)(2616005)(478600001)(6486002)(6666004)(6506007)(6512007)(83380400001)(186003)(316002)(8676002)(66946007)(4326008)(66556008)(6916009)(66476007)(7416002)(41300700001)(8936002)(44832011)(86362001)(2906002)(5660300002)(31696002)(36756003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck9rYlNza0o1d2pZZkpQcU1QWmZ1REJ3VUtRNmNlTHUxeVFPNWxDMFZNenNW?=
 =?utf-8?B?eVdWQWsvWVlyVnNLcURNSk5TRjlPNFlidkxzUm1la0ROYkh3anJTU3RpSW0z?=
 =?utf-8?B?L3FVRWRWcXNQMm9UOTAyQWtSREx6WHJEeS93dzYzOXdOU1Btc3BTMGxTZkhR?=
 =?utf-8?B?azJsa25IdmpPMkpXa25pb1E5d0FGbHJ1QmNVY3FDaU0rT3lsck83elBDTGJJ?=
 =?utf-8?B?Q2NYYmFtMEdyUVo4dENKZlBhNG14QWI1SzJFREJDQ2t6dmJxWUJHU21XTjFW?=
 =?utf-8?B?WlhtMnpXVWE1QXNrYytNU1J0WEllV3N2Q3pDUFNickw0RFVkZjlqbitoa0lH?=
 =?utf-8?B?djl6VklSUGFwa3JaNGlkenlva1o1WDVBSStROXJtNklaYXhTS085UzI2c21R?=
 =?utf-8?B?b3gwOVg2bHlzQTlicnpId2lsUDBtRGdZMEM1VG9zS3VLWk5jekJUSVJUMUoz?=
 =?utf-8?B?WGxhVWk1VVUrME1FZGlrT3FEcnVhbUNhd0NDQWV0dlJTclVSNzhxQ3NVWllu?=
 =?utf-8?B?VTN4Qk53R1I0RUNvOE4vSmE5WjFtN3JOUm5vaFRkZTl2aW9HdnBMeHN3OWVk?=
 =?utf-8?B?VzRYYkZOd2wrd0lROW9UU3IxdStTSG9VYTVvdVBMTkFSQzNzd3gwTWkrREw1?=
 =?utf-8?B?dC92NCtDNERaZ0t1dVVEVG5HOEYvN2NhakFzdFBnUWpZWmZQWUdoVTlLMExN?=
 =?utf-8?B?U1BmbnVPV2VEWDg4RVdJUU1KM0JVVTRrTHY3SjBwZVBXRXQ3NVJVS0Eyc3JI?=
 =?utf-8?B?aFBMVlZFOU1vdHFLeksrZlpTUFpvR1RvOTh1MHk2OEkxVmorOWZQRVhaRjQz?=
 =?utf-8?B?akRFQWFCakcwemxRQVp1RmNmRERDbnVuOE0ySXorWDNMOW41V2xkQ2V4ZHBL?=
 =?utf-8?B?MXhUakRwSmxVZUNWbzFycE4zRllSRUkvWDAvemNBbWExa0JoVnArMk96bnJw?=
 =?utf-8?B?ekFDQWpHaVhMRmVWQjNCWGJYbEg3VEpFajJ6ekJqcW5FYkhYcFlCWnZ5Rzdq?=
 =?utf-8?B?OXhINnB2TExoS01YTWdhSUVUaGVlT0dONmxhY0QreVlWMDVHUEI1MjFsWk9C?=
 =?utf-8?B?L3RSNWNsMFM3dXdXUDB0SXY1VlZrVE1ka1RDVEFqbWtKdFN1dCtHSm5GbC94?=
 =?utf-8?B?cm01V3c1ZmxyWnVYUk1FU2hMVURjb2ovbk4vZnRUTDI5M0N3ZTJQOUJEVjIw?=
 =?utf-8?B?WSt6eWVBeVFqOVcvWnpNVDBJMTdUZVZNR0MxOGVOZHg2eUNZek5NSDZ6MkUx?=
 =?utf-8?B?RXdtSytuTVREeEtSc1RYaTdQelJpaStZa0twUytXN2N2UWVicjMwSHRlR2gz?=
 =?utf-8?B?YWNwa1lhL1d4S2JuNHNER3ZFRW1PNGs1eVBRQmcvdCtOb3UwY3h4YzBZQlZG?=
 =?utf-8?B?dUxSL2M4WHo4SFU0TXNaVDlGVXA3VDJ4em9vYk5EejRFR0NvekVIWStVUkp4?=
 =?utf-8?B?dTlmZmNFQXV2RFIxczRrTmJCYVcxTmQvV1l0SGJRKzBuYnJxa2RDem53V0NP?=
 =?utf-8?B?NTU5Q3I3T1NKVzlZRE9HdjcvbVM1eU5BVm44WitlRUMrblo0THo3RGpxdWlz?=
 =?utf-8?B?dC9WdVdXL1lOSWMzMG10T0h5MFZUNDg2cU96RWpGQkRwOGc2Vkt0ZjR1VFc0?=
 =?utf-8?B?dGdnMXJQRjZqQVFESTNtcUFYNkZ1OW1IUzJFM1pMeHFBWmE0VWJKUWlNblg4?=
 =?utf-8?B?OXlvMGlOV0IxNHpsR0pEbnZHQ3FYODFQYTBLWENTKzBCZTFuM3IrU0lhZk5O?=
 =?utf-8?B?R2FRVEl5S2MrdmlLalcyVWJ4bmZKZzZENkdlRUw1ckJSZHRzOFRmYnpHTWNG?=
 =?utf-8?B?dHRSY1IyOHNUWVFSWG5KUDQ5THJ5c2xTUGZEWnZURTZKR1NkQzVrOWh6ZTlw?=
 =?utf-8?B?a1BLdEJrVHdQdTh2RGxzeXptS0l1VW94RCtVTmFNaE1kZmJTY2xBQWJIVGhW?=
 =?utf-8?B?NW9vNUQzQTQxbFZBdkMvV2VINllaNVVFZlgvdE53ajVEdkw5VGRubWhDR0dL?=
 =?utf-8?B?T1FqQjdnU0tZZGNna3B6VXdkVDFmczM0cU1yTVJQanZHUDlLNW1WOXlId0VX?=
 =?utf-8?B?NGpYUzBEUS9TdXllMGdYUEVNTnJBeFNkbHNlYUU0aUJTTlVQR0V2T21IeUhU?=
 =?utf-8?B?Y1RNSG8yMnVIbFh5TW14SWpPS3NkQVpTVEszU1h6VzF2NXlYVVpxdHc0ak9y?=
 =?utf-8?Q?SvhLevusybHNU06/s19JLLc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MEs1UWZRMkYzOU1vK2xVaXBTNEFvbVZXdlVNbFptV1VLTU9nc1JtV3poMGpD?=
 =?utf-8?B?cko4eUQzWDhqMDRlN3k3QWxBZkg0NnBSVUM4ZVVzK2hrZDJzVEFENS83UGlP?=
 =?utf-8?B?WUlGSG5MWGVVYU5vVmNOekJUTFdMNHArdzV6SG94TTJUVmgrOUMyR2hGVVV6?=
 =?utf-8?B?K3FRYnhPV3phYkV2SW1tOFpYZ0cvcnFSbjhvVUVVRDN0VmJYN2t6TEVrMU02?=
 =?utf-8?B?cmJCMkZEWjNyY0pZbFVYN2hYR2FRRGQ1WlNzbEV4WG56UVdkQ2thTkxrMmlM?=
 =?utf-8?B?U2RldVBVTmZ0cXhaSEpiQnhOWFZtUkttVUNybXRxRk15aHdtclVtc1drSGx0?=
 =?utf-8?B?UEEwWEdKUGVXVGhzaWdKd05OdG5XYUVxVmxGa3ZuM2FwMk5tMHYrcGpFQi9Z?=
 =?utf-8?B?a1FDTUpBcU05UXFLeWNHajU5UGh6LzRKL0pobnhrcWJRb3AwNEtXeWtuOUc1?=
 =?utf-8?B?WXhoeUkwMnlDc1JNbS9Ud3dRZW5TTzFZS3hjU3ZNTktOZVBZbTYvMkRFazRt?=
 =?utf-8?B?Y21TcTQyRjAvelBFWndYbUdpK1RtdTJ2SWdzNkZTeXgrQkJtVnFydmM3ZDBH?=
 =?utf-8?B?eHRLUzhTbzIra3hDQnc5TlFTNjJSSzBBZ1pNRlhYcjhNTkxtaWkwelYrUXdS?=
 =?utf-8?B?N3Z4RUdkcGMxd1E4RmlGTlJCZExONlhYeTQ4MVlFcnliY2E5Mm94Z3ZiT3BF?=
 =?utf-8?B?dlJuMXJ3UG9HSWdFWitsRnc0RjZhSjVTb2VNa09ESjlrOFpLVzMrNzl4SHhh?=
 =?utf-8?B?SzZUblUxdHJmcWNTK25XNklUbkloNVF5eEx6cHRja3NKTjQ2eUNKckh1MGM0?=
 =?utf-8?B?RHkwR3dDc3JTK05NV1pJVnY1RzlWajViU3hRWER0WmlMaDZFdlE3S3VzaWtY?=
 =?utf-8?B?Ym1Uc3lWL3puUXRqY1JsQ1JTM0RTSXZ3RnMrSEdWcEpqcmZFNGlBbzlBRDJL?=
 =?utf-8?B?Zld0Wmx0TUFIMk1HY2ZxZnZFOE1xcnlrcFU4VTE3SXgyeDE3TEZ1Qko4ZHAz?=
 =?utf-8?B?ejBEOXd1a2dVSXd1RjNueitzQVpnSnpYczhFTldxeDExVURuMkNkOGdCZE1o?=
 =?utf-8?B?M0ovZm5wT2NOaVV4TWhDRlZlNDF6R3IrUGpaZHJIUEtJc2N4QTZxc2x3S2xm?=
 =?utf-8?B?WnMvd1M1dFQ2RnI3ZzJGM2tsWWZ2SXBBaFk3b2dReUNsUVVuOXF2QXJWU25I?=
 =?utf-8?B?dzdjNWFwMWhoQ29SMUt0ZWZDOG9vM3J1OXcrQWdocWFtNDlyWVB1VUpEaWhp?=
 =?utf-8?B?M0ZWTFZmT25QUlFzSjZVZDNISThYWlZKU2J5SWZiMmFyekJNZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7f9b5d-bd18-4413-c913-08db137a955a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 19:42:21.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oLUvXpqhXoBBazW0gDBvI8tR2NdxvTrtic55ukgK6uXMltHk1NmLFBb0Z0oZs2uH99zKvCAcYXwvzFRMl3CSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_16,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200181
X-Proofpoint-ORIG-GUID: 9VELp_st1ub7qQ6fVhgTLaoR8WQW9pm1
X-Proofpoint-GUID: 9VELp_st1ub7qQ6fVhgTLaoR8WQW9pm1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20/02/2023 19:03, Alexei Starovoitov wrote:
> On Fri, Feb 17, 2023 at 11:10:30PM +0000, Alan Maguire wrote:
>> Calling conventions dictate which registers are used for
>> function parameters.
>>
>> When a function is optimized however, we need to ensure that
>> the non-optimized parameters do not violate expectations about
>> register use as this would violate expectations for tracing.
>> At CU initialization, create a mapping from parameter index
>> to expected DW_OP_reg, and use it to validate parameters
>> match with expectations.  A parameter which is passed via
>> the stack, as a constant, or uses an unexpected register,
>> violates these expectations and it (and the associated
>> function) are marked as having unexpected register mapping.
>>
>> Note though that there is as exception here that needs to
>> be handled; when a (typedef) struct is passed as a parameter,
>> it can use multiple registers so will throw off later register
>> expectations.  Exempt functions that have unexpected
>> register usage _and_ struct parameters (examples are found
>> in the "tracing_struct" test).
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  dwarf_loader.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++---
>>  dwarves.h      |   5 +++
>>  2 files changed, 109 insertions(+), 5 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index acdb68d..014e130 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1022,6 +1022,51 @@ static int arch__nr_register_params(const GElf_Ehdr *ehdr)
>>  	return 0;
>>  }
>>  
>> +/* map from parameter index (0 for first, ...) to expected DW_OP_reg.
>> + * This will allow us to identify cases where optimized-out parameters
>> + * interfere with expectations about register contents on function
>> + * entry.
>> + */
>> +static void arch__set_register_params(const GElf_Ehdr *ehdr, struct cu *cu)
>> +{
>> +	memset(cu->register_params, -1, sizeof(cu->register_params));
>> +
>> +	switch (ehdr->e_machine) {
>> +	case EM_S390:
>> +		/* https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf */
>> +		cu->register_params[0] = DW_OP_reg2;	// %r2
>> +		cu->register_params[1] = DW_OP_reg3;	// %r3
>> +		cu->register_params[2] = DW_OP_reg4;	// %r4
>> +		cu->register_params[3] = DW_OP_reg5;	// %r5
>> +		cu->register_params[4] = DW_OP_reg6;	// %r6
>> +		return;
>> +	case EM_X86_64:
>> +		/* //en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI */
>> +		cu->register_params[0] = DW_OP_reg5;	// %rdi
>> +		cu->register_params[1] = DW_OP_reg4;	// %rsi
>> +		cu->register_params[2] = DW_OP_reg1;	// %rdx
>> +		cu->register_params[3] = DW_OP_reg2;	// %rcx
>> +		cu->register_params[4] = DW_OP_reg8;	// %r8
>> +		cu->register_params[5] = DW_OP_reg9;	// %r9
>> +		return;
>> +	case EM_ARM:
>> +		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32.rst#machine-registers */
>> +	case EM_AARCH64:
>> +		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#machine-registers */
>> +		cu->register_params[0] = DW_OP_reg0;
>> +		cu->register_params[1] = DW_OP_reg1;
>> +		cu->register_params[2] = DW_OP_reg2;
>> +		cu->register_params[3] = DW_OP_reg3;
>> +		cu->register_params[4] = DW_OP_reg4;
>> +		cu->register_params[5] = DW_OP_reg5;
>> +		cu->register_params[6] = DW_OP_reg6;
>> +		cu->register_params[7] = DW_OP_reg7;
>> +		return;
>> +	default:
>> +		return;
>> +	}
>> +}
>> +
>>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>  					struct conf_load *conf, int param_idx)
>>  {
>> @@ -1075,18 +1120,28 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>  		if (parm->has_loc &&
>>  		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
>>  			loc.exprlen != 0) {
>> +			int expected_reg = cu->register_params[param_idx];
>>  			Dwarf_Op *expr = loc.expr;
>>  
>>  			switch (expr->atom) {
>>  			case DW_OP_reg0 ... DW_OP_reg31:
>> +				/* mark parameters that use an unexpected
>> +				 * register to hold a parameter; these will
>> +				 * be problematic for users of BTF as they
>> +				 * violate expectations about register
>> +				 * contents.
>> +				 */
>> +				if (expected_reg >= 0 && expected_reg != expr->atom)
>> +					parm->unexpected_reg = 1;
>> +				break;
> 
> Overall I guess it's a step forward, since it addresses the immediate issue,
> but probably too fragile long term.
> 
> Your earlier example:
>  __bpf_kfunc void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> 
> had
> 0x0891dabe:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x7a) loclist = 0x00f50eb1:
>                      [0xffffffff82031185, 0xffffffff8203119e): DW_OP_reg5 RDI
>                      [0xffffffff8203119e, 0xffffffff820311cc): DW_OP_reg3 RBX
>                      [0xffffffff820311cc, 0xffffffff820311d1): DW_OP_reg5 RDI
>                      [0xffffffff820311d1, 0xffffffff820311d2): DW_OP_reg3 RBX
>                      [0xffffffff820311d2, 0xffffffff820311d8): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
> 
> 0x0891dad4:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x7b) loclist = 0x00f50eda:
>                      [0xffffffff82031185, 0xffffffff820311bc): DW_OP_reg1 RDX
>                      [0xffffffff820311bc, 0xffffffff820311c8): DW_OP_reg0 RAX
>                      [0xffffffff820311c8, 0xffffffff820311d1): DW_OP_reg1 RDX)
>                   DW_AT_name    ("acked")
> 
> Both args will fail above check. If I'm reading above code correctly.
> It checks that every reg in DW_AT_location matches ?

It checks location info for those that have it; so in this case the location
lists specify rdi on entry for the first parameter (sk)


0x068a0f3b:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x74) loclist = 0x00a4c5a0:
                     [0xffffffff81b87849, 0xffffffff81b87866): DW_OP_reg5 RDI
                     [0xffffffff81b87866, 0xffffffff81b87899): DW_OP_reg3 RBX
                     [0xffffffff81b87899, 0xffffffff81b878a0): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                  DW_AT_name    ("sk")
                  DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
                  DW_AT_decl_line       (446)
                  DW_AT_type    (0x06886461 "sock *")


no location info for the second (ack):

0x068a0f47:     DW_TAG_formal_parameter
                  DW_AT_name    ("ack")
                  DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
                  DW_AT_decl_line       (446)
                  DW_AT_type    (0x06886451 "u32")

...so matching it is skipped, and rdx as the first element in the location list
for the third parameter (acked):

0x068a0f52:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x75) loclist = 0x00a4c5bb:
                     [0xffffffff81b87849, 0xffffffff81b87884): DW_OP_reg1 RDX
                     [0xffffffff81b87884, 0xffffffff81b87890): DW_OP_reg0 RAX
                     [0xffffffff81b87890, 0xffffffff81b87898): DW_OP_reg1 RDX)
                  DW_AT_name    ("acked")
                  DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
                  DW_AT_decl_line       (446)
                  DW_AT_type    (0x06886451 "u32")


So this would be okay using the register-checking approach.

> Or just first ?
> 
>>  			case DW_OP_breg0 ... DW_OP_breg31:
>>  				break;
>>  			default:
>> -				parm->optimized = 1;
>> +				parm->unexpected_reg = 1;
>>  				break;
>>  			}
>>  		} else if (has_const_value) {
>> -			parm->optimized = 1;
>> +			parm->unexpected_reg = 1;
> 
> Is this part too restrictive as well?
> Just because one arg is constant it doesn't mean that the calling convention
> is not correct for this and other args.
> 

Great catch; this part is wrong; should just be parm->optimized = 1 as it
was before.
